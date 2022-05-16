import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :coingecko_messenger, CoingeckoMessenger.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "coingecko_messenger_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :coingecko_messenger, CoingeckoMessengerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "PnbF/kgXFOA3fIS/+BDQet2+DY95kXWJQYqbZei3ooB3cr7s79Fh8BFDKcBYqBGT",
  server: false

# In test we don't send emails.
config :coingecko_messenger, CoingeckoMessenger.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
