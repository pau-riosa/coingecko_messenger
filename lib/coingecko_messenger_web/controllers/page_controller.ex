defmodule CoingeckoMessengerWeb.PageController do
  use CoingeckoMessengerWeb, :controller

  require Logger

  @verification_token Application.compile_env(:coingecko_messenger, :verify_token)
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @doc """
  %{"hub.challenge" => "1065770328", "hub.mode" => "subscribe", "hub.verify_token" => "LihGv2fR3vMsnBnue02Dnma8b2B+O/hpIBRwK1FW1UD9tcBOBhnSryBLFNaSFxDX"}
  """
  def webhook(conn, params) do
    %{"hub.challenge" => challenge, "hub.verify_token" => verify_token} = params

    if verify_token === @verification_token do
      Logger.info("verification granted.")
      resp(conn, 200, challenge)
    else
      Logger.error("verification failed, token mismatch.")
      render(conn, "index.html")
    end
  end
end
