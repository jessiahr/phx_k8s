defmodule PhxK8s.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PhxK8s.Repo,
      # Start the Telemetry supervisor
      PhxK8sWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhxK8s.PubSub},
      # Start the Endpoint (http/https)
      PhxK8sWeb.Endpoint
      # Start a worker by calling: PhxK8s.Worker.start_link(arg)
      # {PhxK8s.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxK8s.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhxK8sWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
