defmodule PhxK8s.Repo do
  use Ecto.Repo,
    otp_app: :phx_k8s,
    adapter: Ecto.Adapters.Postgres
end
