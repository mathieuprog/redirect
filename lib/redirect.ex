defmodule Redirect do
  import Plug.Conn
  alias Phoenix.Controller

  def init(opts) do
    cond do
      opts[:to] -> nil
      opts[:external] -> nil
      true -> raise ArgumentError, "expected :to or :external option"
    end

    cond do
      opts[:type] -> nil
      true -> raise ArgumentError, "expected :type option"
    end

    case opts[:type] do
      :permanent -> nil
      :temporary -> nil
      _ -> raise ArgumentError, "expected :type option to be set to :permanent or :temporary"
    end

    opts
  end

  def call(conn, opts) do
    conn
    |> put_redirect_status(opts[:type])
    |> do_redirect(opts)
    |> halt()
  end

  defp put_redirect_status(conn, :permanent), do: put_status(conn, 301)
  defp put_redirect_status(conn, :temporary), do: put_status(conn, 302)

  defp do_redirect(conn, opts) do
    cond do
      to = opts[:to] -> Controller.redirect(conn, to: to)
      external = opts[:external] -> Controller.redirect(conn, external: external)
    end
  end

  defmacro redirect(path, "http" <> _ = to, type) do
    quote do
      forward(unquote(path), unquote(__MODULE__), external: unquote(to), type: unquote(type))
    end
  end

  defmacro redirect(path, to, type) do
    quote do
      forward(unquote(path), unquote(__MODULE__), to: unquote(to), type: unquote(type))
    end
  end
end
