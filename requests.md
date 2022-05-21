## Greetings

curl -X POST -H "Content-Type: application/json" -d '{
  "get_started": {"payload": "GET_STARTED"},
  "greeting": [{"locale": "default", "text":"Welcome to Paugramming {{user_first_name}}?"}],
  "persistent_menu": [
      {
          "locale": "default",
          "composer_input_disabled": false,
          "call_to_actions": [
              {
                  "type": "postback",
                  "title": "HELP",
                  "payload": "HELP"
              } 
          ]
      }
  ]

}' "https://graph.facebook.com/v13.0/me/messenger_profile?access_token=EAAuTXyKJAPEBAA9VtCZABCzYnWM6y8W1oLZBNQdhSxX11xFiWfBValkSFDRToNpwT8XK1Vn8CsuhvNTpV2MnfmkDT7aGpx4KDanPcDrZAJJ3HzVBi7NSFFlaBEutdjZCe96Mj4kCGcopR3rVW0utfNPZA1S6t1nqLxIIAmHLAaLpLlQCze1j1stmZAebmg0GMxk43N5ZAguegZDZD"

## Sending API
messaging-type: RESPONSE, UPDATE, MESSAGE_TAG
curl -X POST -H "Content-Type: application/json" -d '{
  "sender_action": "typing_on",
  "recipient": {
    "id": "7626935410681045"
  },
}' "https://graph.facebook.com/v13.0/me/messages?access_token=EAAuTXyKJAPEBAMUaRGLwRLtMd9uUN2BefRuJpuYbaF4uaOjIMU676ZAVpAfNAjLf7CZA9l1ESj1JnYZAyF7WcnNdwLF2Aul9FQI0gIsGotZA8bnllLpz4ShhPvc9qkoTUzvaNF5H52t0b87Yb4q0jp1RjFJ6mIVS1NzrF0W13ZB7u65GI4i9WaW1hPwZAqpSZCVW8NfwBNhigZDZD"

curl -X POST -H "Content-Type: application/json" -d '{
  "messaging_type": "RESPONSE",
  "recipient": {
    "id": "7626935410681045"
  },
  "message": {"text": "hello, world!" }
}' "https://graph.facebook.com/v13.0/me/messages?access_token=EAAuTXyKJAPEBAMUaRGLwRLtMd9uUN2BefRuJpuYbaF4uaOjIMU676ZAVpAfNAjLf7CZA9l1ESj1JnYZAyF7WcnNdwLF2Aul9FQI0gIsGotZA8bnllLpz4ShhPvc9qkoTUzvaNF5H52t0b87Yb4q0jp1RjFJ6mIVS1NzrF0W13ZB7u65GI4i9WaW1hPwZAqpSZCVW8NfwBNhigZDZD"


## Generic Template Request

curl -X POST -H "Content-Type: application/json" -d '{
  "recipient":{
    "id": "7626935410681045"
  },
  "message":{
    "attachment":{
      "type":"template",
      "payload":{
        "template_type":"generic",
        "elements":[
           {
            "title":"Hello!",
            "buttons":[
             {
                "type":"postback",
                "title":"Start Searching",
                "payload":"Search"
              } 
            ]
          }
        ]
      }
    }
  }
}' "https://graph.facebook.com/v2.6/me/messages?access_token=EAAuTXyKJAPEBAMUaRGLwRLtMd9uUN2BefRuJpuYbaF4uaOjIMU676ZAVpAfNAjLf7CZA9l1ESj1JnYZAyF7WcnNdwLF2Aul9FQI0gIsGotZA8bnllLpz4ShhPvc9qkoTUzvaNF5H52t0b87Yb4q0jp1RjFJ6mIVS1NzrF0W13ZB7u65GI4i9WaW1hPwZAqpSZCVW8NfwBNhigZDZD"



## Quick Replies

curl -X POST -H "Content-Type: application/json" -d '{
  "recipient":{
    "id":"7626935410681045"
  },
  "messaging_type": "RESPONSE",
  "message":{
    "text": "SELECT A COIN",
    "quick_replies":[
      {
        "content_type":"text",
        "title":"Red",
        "payload":"red",
        "image_url":"http://example.com/img/red.png"
      },{
        "content_type":"text",
        "title":"Green",
        "payload":"red",
        "image_url":"http://example.com/img/green.png"
      }
    ]
  }
}' "https://graph.facebook.com/v13.0/me/messages?access_token=EAAuTXyKJAPEBAMUaRGLwRLtMd9uUN2BefRuJpuYbaF4uaOjIMU676ZAVpAfNAjLf7CZA9l1ESj1JnYZAyF7WcnNdwLF2Aul9FQI0gIsGotZA8bnllLpz4ShhPvc9qkoTUzvaNF5H52t0b87Yb4q0jp1RjFJ6mIVS1NzrF0W13ZB7u65GI4i9WaW1hPwZAqpSZCVW8NfwBNhigZDZD" 

### Postback button

curl -X POST -H "Content-Type: application/json" -d '{
  "recipient":{
    "id":"7626935410681045"
  },
  "message":{
    "attachment":{
      "type":"template",
      "payload":{
        "template_type":"button",
        "text":"Welcome To Coingecko Messenger",
        "buttons":[
          {
            "type":"postback",
            "title":"Search for Coins",
            "payload": "SEARCH_FOR_COINS"
          }
        ]
      }
    }
  }
}' "https://graph.facebook.com/v2.6/me/messages?access_token=EAAuTXyKJAPEBAMUaRGLwRLtMd9uUN2BefRuJpuYbaF4uaOjIMU676ZAVpAfNAjLf7CZA9l1ESj1JnYZAyF7WcnNdwLF2Aul9FQI0gIsGotZA8bnllLpz4ShhPvc9qkoTUzvaNF5H52t0b87Yb4q0jp1RjFJ6mIVS1NzrF0W13ZB7u65GI4i9WaW1hPwZAqpSZCVW8NfwBNhigZDZD"


### List Template

curl -X POST -H "Content-Type: application/json" -d '{
  "recipient":{
    "id":"7626935410681045"
  }, 
  "message": {
    "attachment": {
      "type": "template",
      "payload": {
        "template_type": "list",
        "top_element_style": "compact",
        "elements": [
          {
            "title": "",
            "subtitle": "See all our colors",
            "image_url": "https://originalcoastclothing.com/img/collection.png",          
          },
          {
            "title": "Classic White T-Shirt",
            "subtitle": "See all our colors",
            "default_action": {
              "type": "web_url",
              "url": "https://originalcoastclothing.com/view?item=100",
              "messenger_extensions": false,
              "webview_height_ratio": "tall"
            }
          },
          {
            "title": "Classic Blue T-Shirt",
            "image_url": "https://originalcoastclothing.com/img/blue-t-shirt.png",
            "subtitle": "100% Cotton, 200% Comfortable",
            "default_action": {
              "type": "web_url",
              "url": "https://originalcoastclothing.com/view?item=101",
              "messenger_extensions": true,
              "webview_height_ratio": "tall",
              "fallback_url": "https://originalcoastclothing.com/"
            },
            "buttons": [
              {
                "title": "Shop Now",
                "type": "web_url",
                "url": "https://originalcoastclothing.com/shop?item=101",
                "messenger_extensions": true,
                "webview_height_ratio": "tall",
                "fallback_url": "https://originalcoastclothing.com/"            
              }
            ]        
          }
        ],
         "buttons": [
          {
            "title": "View More",
            "type": "postback",
            "payload": "payload"            
          }
        ]  
      }
    }
  }
}' "https://graph.facebook.com/me/messages?access_token=PAGE_ACCESS_TOKEN"
