import os
import base64
import requests
import RPi.GPIO as GPIO
import time
import sys
from gpiozero import DistanceSensor
from clarifai.rest import ClarifaiApp
from datetime import datetime

servoPIN1 = 2
GPIO.setmode(GPIO.BCM)
GPIO.setup(servoPIN1, GPIO.OUT)
pwm1=GPIO.PWM(servoPIN1,50)
pwm1.start(0)

servoPIN2 = 3
GPIO.setmode(GPIO.BCM)
GPIO.setup(servoPIN2, GPIO.OUT)
pwm2=GPIO.PWM(servoPIN2,50)
pwm2.start(0)

def SetAngle(angle):
    duty1 = angle/18 + 2
    duty2 = (180 - angle)/18 + 2
    GPIO.output(servoPIN1, True)
    pwm1.ChangeDutyCycle(duty1)
    GPIO.output(servoPIN2, True)
    pwm2.ChangeDutyCycle(duty2)
    time.sleep(1)
    GPIO.output(servoPIN1, False)
    pwm1.ChangeDutyCycle(0)
    GPIO.output(servoPIN2, False)
    pwm2.ChangeDutyCycle(0)

SetAngle(100)

#checks if garbage on the sorter
sensor1 = DistanceSensor(trigger=19, echo=26)

#checks trash
sensor2 = DistanceSensor(trigger=20, echo=21)

#checks recycling
sensor3 = DistanceSensor(trigger=17, echo=27)

ip = "192.168.86.32"

print(sensor1.distance * 100)
time.sleep(.1)
print(sensor1.distance * 100)
time.sleep(.1)
print(sensor1.distance * 100)
time.sleep(.1)
print(sensor1.distance * 100)
time.sleep(.1)
print(sensor1.distance * 100)
time.sleep(.1)

while True:
    print(sensor1.distance * 100)
    time.sleep(0.1)
    if sensor1.distance * 100 < 20:
        print("hit")
        time.sleep(0.5)
        stream1 = os.popen('fswebcam /home/pi/test/Images/image.jpg')
        output1 = stream1.read()
        my_string1 = ""
        
        with open("/home/pi/test/Images/image.jpg", "rb") as img_file1:
            my_string1 = base64.b64encode(img_file1.read())
            
        app = ClarifaiApp(api_key='71a594e3144a4ca89c761a6a5504c4a8')

        model = app.public_models.general_model
        response = model.predict_by_filename('Images/image.jpg')

        recycle = False
        for x in response['outputs'][0]['data']['concepts']:
            if x['name'] == "recycling" or x['name'] == "plastic":
                print(x['name'])
                recycle = True

        if recycle:
            SetAngle(175)
            time.sleep(2)
            SetAngle(100)
        else:
            SetAngle(0)
            time.sleep(2)
            SetAngle(120)
            print('not recycle-able')
        
        time.sleep(0.5)
        trashCount = (round(abs(28 - sensor2.distance * 100))/30) * 100
        recycleCount = (round(abs(28 - sensor3.distance * 100))/30) * 100
        dateNow = datetime.now() 
        #print(trashCount)
        #print(recycleCount)
        requests.get("http://1b0d329c.ngrok.io/iphone/update?trash=" + str(trashCount) + "&recycle=" + str(recycleCount))
        requests.get("http://1b0d329c.ngrok.io/iphone/image?type=recycled" + "&date=" + str(dateNow.year) + "-" + str(dateNow.strftime("%m")) + "-" + str(dateNow.strftime("%d")) + "_" + str(dateNow.strftime("%I")) + ":" + str(dateNow.strftime("%M")) + str(dateNow.strftime("%S")) + "&b64=" + str(my_string1))
        url = "http://1b0d329c.ngrok.io/iphone/image?type=recycled" + "&date=" + str(dateNow.year) + "-" + str(dateNow.strftime("%m")) + "-" + str(dateNow.strftime("%d")) + "_" + str(dateNow.strftime("%I")) + ":" + str(dateNow.strftime("%M")) + str(dateNow.strftime("%S"))
        files = {'media': open('Images/image.jpg', 'rb')}
        requests.get(url)
        requests.post("http://1b0d329c.ngrok.io/iphone/imgupload?image=" + str(files))

# Getting the libraries we need

# Initialize ultrasonic sensor

    
