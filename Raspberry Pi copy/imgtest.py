import requests

url = "https://7c5a521b.ngrok.io/iphone/upload"

payload = {}
files = [
  ('wallpaper', open('/Users/aryatschand/Documents/7fb566418866a86cf1ddc6306573145c.jpg','rb'))
]
headers = {
  'Content-Type': 'multipart/form-data; boundary=--------------------------655048137320416567120708'
}

response = requests.request("POST", url, headers=headers, data = payload, files = files)

print(response.text.encode('utf8'))