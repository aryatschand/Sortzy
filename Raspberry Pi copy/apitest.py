import requests

url = "http://7c5a521b.ngrok.io/iphone/upload"

payload = {}
files = [
  ('wallpaper', open('/Users/aryatschand/Documents/7fb566418866a86cf1ddc6306573145c.jpg','rb'))
]

response = requests.request("POST", url, data = payload, files = files)

print(response.text.encode('utf8'))
