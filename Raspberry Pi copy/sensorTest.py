import os
import base64
import requests
import RPi.GPIO as GPIO
import time
import sys
from gpiozero import DistanceSensor

servoPIN1 = 2
GPIO.setmode(GPIO.BCM)
GPIO.setup(servoPIN1, GPIO.OUT)
pwm1=GPIO.PWM(servoPIN1,50)
pwm1.start(90)

servoPIN2 = 3
GPIO.setmode(GPIO.BCM)
GPIO.setup(servoPIN2, GPIO.OUT)
pwm2=GPIO.PWM(servoPIN2,50)
pwm2.start(90)

sensor1 = DistanceSensor(trigger=19, echo=26)
sensor2 = DistanceSensor(trigger=20, echo=21)
sensor3 = DistanceSensor(trigger=6, echo=13)

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

SetAngle(90)
SetAngle(0)    
SetAngle(135)
SetAngle(0)
SetAngle(90)
pwm1.stop()
pwm2.stop()

while True:
    # Wait 2 seconds
    time.sleep(2)
                  # Get the distance in metres

    # But we want it in centimetres
    distance1 = sensor1.distance * 100
    distance2 = sensor2.distance * 100
    distance3 = sensor3.distance * 100

    # We would get a large decimal number so we will round it to 2 places

    # Print the information to the screen
    print("Distance1: {} cm".format(distance1))
    print("Distance2: {} cm".format(distance2))
    print("Distance3: {} cm".format(distance3))

GPIO.cleanup()