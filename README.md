# Redirect

**Redirect** provides a macro for your router to redirect a request at a given
path to another.

In your `router.ex` file, use the `redirect/3` macro to redirect a request:

```elixir
import Redirect

redirect "/path", "/new-path", :permanent
```

## Installation

Add `redirect` for Elixir as a dependency in your `mix.exs` file:

```elixir
def deps do
  [
    {:redirect, "~> 0.1.0"}
  ]
end
```

## HexDocs

HexDocs documentation can be found at [https://hexdocs.pm/redirect](https://hexdocs.pm/redirect).

