curl -X GET  -H 'accept: application/json' -d '{
"include_platform" : true
}' "https://api.coingecko.com/api/v3/coins/list"

curl -X 'GET' -H 'accept: application/json' "https://api.coingecko.com/api/v3/coins/zytara-dollar/market_chart?vs_currency=usd&days=14"
