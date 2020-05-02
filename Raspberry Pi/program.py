import os
import base64
import requests
import RPi.GPIO as GPIO
import time
import sys
import sys
from gpiozero import DistanceSensor

servoPIN1 = 17
GPIO.setmode(GPIO.BCM)
GPIO.setup(servoPIN1, GPIO.OUT)

p1 = GPIO.PWM(servoPIN1, 50) # GPIO 17 for PWM with 50Hz
p1.start(2.5) # Initialization

servoPIN2 = 18
GPIO.setmode(GPIO.BCM)
GPIO.setup(servoPIN2, GPIO.OUT)

p2 = GPIO.PWM(servoPIN2, 50) # GPIO 17 for PWM with 50Hz
p2.start(2.5)

sensor1 = DistanceSensor(trigger=19, echo=20)
sensor2 = DistanceSensor(trigger=21, echo=22)
sensor3 = DistanceSensor(trigger=23, echo=24)

ip = "192.168.86.32"

while True:

    takePic = sensor1.distance

    if takePic < 1:
        stream1 = os.popen('fswebcam /home/pi/test/Images/image.jpg')
        output1 = stream1.read()
        mystring1 = ""
            
        
        with open("/home/pi/test/Images/image.jpg", "rb") as img_file1:
            my_string1 = base64.b64encode(img_file1.read())
            
        response = requests.get("http://"+ ip + ":5000/?usage=demo&image=" + str(my_string1))

        if response.text == "recycle":
            p1.ChangeDutyCycle(5)
            p2.ChangeDutyCycle(5)
            time.sleep(0.5)
        else:
            p1.ChangeDutyCycle(2)
            p2.ChangeDutyCycle(2)
            time.sleep(0.5)
    else:
        recycling = sensor2.distance
        trash = sensor3.distance

        response = requests.get("http://"+ ip + ":5000/?usage=demo&image=" + str(recycling))
    