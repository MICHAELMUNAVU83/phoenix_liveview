defmodule PhoenixTherapist.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_therapist,
    adapter: Ecto.Adapters.Postgres
end
