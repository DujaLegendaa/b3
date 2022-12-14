defmodule B3.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: B3.Worker.start_link(arg)
      # {B3.Worker, arg}
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: B3.Endpoint,
        options: Application.get_env(:b3, B3.Endpoint)
      )
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: B3.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
