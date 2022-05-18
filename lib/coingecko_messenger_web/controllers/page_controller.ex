defmodule CoingeckoMessengerWeb.PageController do
  use CoingeckoMessengerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def webhook(conn, _params) do
    render(conn, "index.html")
  end

  def webhook_post(conn, params) do
    raise params
  end
end
