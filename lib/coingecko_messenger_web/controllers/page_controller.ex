defmodule CoingeckoMessengerWeb.PageController do
  use CoingeckoMessengerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def webhook(conn, params) do
    IO.inspect(params)
    render(conn, "index.html")
  end
end
