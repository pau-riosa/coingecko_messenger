defmodule CoingeckoMessenger.Repo do
  use Ecto.Repo,
    otp_app: :coingecko_messenger,
    adapter: Ecto.Adapters.Postgres
end
