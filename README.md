# Redirect

**Redirect** provides a macro for your router to redirect a request at a given
path to another.

In your `router.ex` file, use the `redirect/3` macro to redirect a request:

```elixir
import Redirect

redirect "/path", "/new-path", :permanent, preserve_query_string: true
```

⚠️ `redirect/3` doesn't work inside scopes (`scope/2`/`scope/3`/`scope/4`)

The third argument passed to `redirect/3` must be either `:permanent` or
`:temporary`. This setting sets the HTTP status code to 301 or 302 respectively.

The fourth optional argument allows to specify whether the query string must be preserved in the
target URL or not (defaults to false).

Note that `Plug.Conn` will be halted right after redirecting.

You may also import `:redirect`'s formatter configuration by importing
`redirect` into your `.formatter.exs` file (this allows for example to keep
`redirect "/path", "/new-path", :permanent` without parentheses when running `mix format`).

```elixir
[
  import_deps: [:ecto, :phoenix, :redirect],
  #...
]
```

## Installation

Add `redirect` for Elixir as a dependency in your `mix.exs` file:

```elixir
def deps do
  [
    {:redirect, "~> 0.4.0"}
  ]
end
```

## HexDocs

HexDocs documentation can be found at [https://hexdocs.pm/redirect](https://hexdocs.pm/redirect).
