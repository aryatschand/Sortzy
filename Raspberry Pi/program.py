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

# Getting the libraries we need

# Initialize ultrasonic sensor

while True:
	# Wait 2 seconds
	sleep(2)
	
	# Get the distance in metres
	distance = sensor.distance

	# But we want it in centimetres
	distance = sensor.distance * 100

	# We would get a large decimal number so we will round it to 2 places
	distance = round(sensor.distance, 2)

	# Print the information to the screen
	print("Distance: {} cm".format(sensor.distance))
    