defmodule CoingeckoMessengerWeb.PageController do
  use CoingeckoMessengerWeb, :controller

  require Logger

  @verification_token Application.fetch_env!(:coingecko_messenger, :verify_token)
  @page_access_token Application.fetch_env!(:coingecko_messenger, :page_access_token)

  def index(conn, _params) do
    render(conn, "index.html")
  end

  @doc """
  %{"hub.challenge" => "1065770328", "hub.mode" => "subscribe", "hub.verify_token" => "LihGv2fR3vMsnBnue02Dnma8b2B+O/hpIBRwK1FW1UD9tcBOBhnSryBLFNaSFxDX"}
  """
  def webhook(conn, %{"hub.challenge" => challenge, "hub.verify_token" => verify_token} = _params) do
    if verify_token === @verification_token do
      Logger.info("verification granted.")
      resp(conn, 200, challenge)
    else
      Logger.error("verification failed, token mismatch.")
      resp(conn, 404, "verification failed, token mismatch")
    end
  end

  def webhook(conn, %{"entry" => entry} = _params) do
    entry
    |> Enum.map(fn f -> f["messaging"] end)
    |> List.flatten()
    |> hd()
    |> do_webhook()

    resp(conn, 200, "")
  end

  def do_webhook(%{"postback" => %{"payload" => payload}} = postback) do
    case payload do
      # "GET_STARTED" -> search_for_coins(postback)
      # "SEARCH_FOR_COINS" -> show_five_random_coins(postback)
      _ -> :ok
    end
  end

  def do_webhook(%{"message" => %{"quick_reply" => %{"payload" => payload}}} = postback) do
    show_price_in_usd(payload, postback)
  end

  def do_webhook(_), do: :ok

  def show_price_in_usd(payload, postback) do
    path =
      "https://api.coingecko.com/api/v3/coins/#{payload}/market_chart?vs_currency=usd&days=14"

    headers = [{"Content-Type", "application/json"}]

    case get(path, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> Map.get("prices")
        |> Enum.take(14)
        |> Enum.each(fn [price, usd] ->
          message = """
          #{payload} vs USD within 14 days

          #{price} vs #{usd}
          """

          send_message(postback["sender"]["id"], message)
        end)

      _ ->
        :ok
    end
  end

  def send_list_message(recipient_id, elements) do
    path = "https://graph.facebook.com/v13.0/me/messages?access_token=#{@page_access_token}"

    body =
      %{
        recipient: %{id: recipient_id},
        messaging_type: "RESPONSE",
        message: %{
          attachment: %{
            type: "template",
            payload: %{
              template_type: "list",
              elements: elements
            }
          }
        }
      }
      |> Jason.encode!()

    headers = [{"Content-Type", "application/json"}]

    post(path, body, headers)
  end

  def send_message(recipient_id, message) do
    path = "https://graph.facebook.com/v13.0/me/messages?access_token=#{@page_access_token}"

    body =
      %{
        recipient: %{id: recipient_id},
        messaging_type: "RESPONSE",
        message: %{
          text: message
        }
      }
      |> Jason.encode!()

    headers = [{"Content-Type", "application/json"}]

    post(path, body, headers)
  end

  def show_five_random_coins(postback) do
    case get_five_random_coins() do
      [coin1, coin2, coin3, coin4, coin5] ->
        path = "https://graph.facebook.com/v13.0/me/messages?access_token=#{@page_access_token}"

        body =
          %{
            recipient: %{id: postback["sender"]["id"]},
            messaging_type: "RESPONSE",
            message: %{
              text: "SELECT A COIN",
              quick_replies: [
                %{
                  content_type: "text",
                  title: coin1["name"],
                  payload: coin1["id"]
                },
                %{
                  content_type: "text",
                  title: coin2["name"],
                  payload: coin2["id"]
                },
                %{
                  content_type: "text",
                  title: coin3["name"],
                  payload: coin3["id"]
                },
                %{
                  content_type: "text",
                  title: coin4["name"],
                  payload: coin4["id"]
                },
                %{
                  content_type: "text",
                  title: coin5["name"],
                  payload: coin5["id"]
                }
              ]
            }
          }
          |> Jason.encode!()

        headers = [{"Content-Type", "application/json"}]

        post(path, body, headers)

      _ ->
        :ok
    end
  end

  def search_for_coins(postback) do
    path = "https://graph.facebook.com/v2.6/me/messages?access_token=#{@page_access_token}"

    body =
      %{
        recipient: %{id: postback["sender"]["id"]},
        message: %{
          attachment: %{
            type: "template",
            payload: %{
              template_type: "button",
              text: "Welcome to coingecko messenger",
              buttons: [
                %{
                  type: "postback",
                  title: "search for coins",
                  payload: "SEARCH_FOR_COINS"
                }
              ]
            }
          }
        }
      }
      |> Jason.encode!()

    headers = [{"Content-Type", "application/json"}]

    post(path, body, headers)
  end

  defp get_five_random_coins() do
    path = "https://api.coingecko.com/api/v3/coins/list"
    headers = [{"Content-Type", "application/json"}]

    case get(path, headers) do
      {:ok, %HTTPoison.Response{body: body}} ->
        body
        |> Jason.decode!()
        |> Enum.shuffle()
        |> Enum.take(5)

      _ ->
        []
    end
  end

  defp post(path, body, headers), do: HTTPoison.post(path, body, headers)
  defp get(path, headers, options \\ []), do: HTTPoison.get(path, headers, options)
end
