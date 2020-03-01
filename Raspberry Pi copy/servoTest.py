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

SetAngle(0)    
SetAngle(180)
SetAngle(0)
pwm1.stop()
pwm2.stop()
GPIO.cleanup()

