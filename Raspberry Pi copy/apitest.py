from clarifai.rest import ClarifaiApp

app = ClarifaiApp(api_key='71a594e3144a4ca89c761a6a5504c4a8')

model = app.public_models.general_model
response = model.predict_by_filename('bottle.png')

for x in response['outputs'][0]['data']['concepts']:
    if x['name'] == "recycling":
        print("hello")