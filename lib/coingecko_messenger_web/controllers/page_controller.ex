defmodule CoingeckoMessengerWeb.PageController do
  use CoingeckoMessengerWeb, :controller

  require Logger

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def webhook(conn, params) do
    Logger.info(params)
    render(conn, "index.html")
  end
end
