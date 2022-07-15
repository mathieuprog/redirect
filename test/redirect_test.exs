defmodule RedirectTest do
  use ExUnit.Case, async: true
  use Plug.Test

  doctest Redirect

  test "plug redirects permanently" do
    options = Redirect.init(to: "/bar", type: :permanent, opts: [])

    conn = conn(:get, "/foo")
    conn = Redirect.call(conn, options)

    assert conn.status == 301
    assert conn.halted == true
  end

  test "plug redirects temporarily" do
    options = Redirect.init(to: "/bar", type: :temporary, opts: [])

    conn = conn(:get, "/foo")
    conn = Redirect.call(conn, options)

    assert conn.status == 302
    assert conn.halted == true
  end

  test "plug with missing :to and :external option" do
    assert_raise ArgumentError, "expected :to or :external option", fn ->
      Redirect.init(type: :temporary)
    end
  end

  test "plug with missing :type option" do
    assert_raise ArgumentError, "expected :type option", fn ->
      Redirect.init(to: "/bar")
    end
  end

  test "plug with invalid :type option" do
    assert_raise ArgumentError, "expected :type option to be set to :permanent or :temporary", fn ->
      Redirect.init(to: "/bar", type: :forever)
    end
  end
end
