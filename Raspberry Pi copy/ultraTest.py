from gpiozero import DistanceSensor
import time

sensor1 = DistanceSensor(trigger=19, echo=26) 
print('a')
#checks trash
sensor2 = DistanceSensor(trigger=20, echo=21)
print('b')
#checks recycling
sensor3 = DistanceSensor(trigger=17, echo=27)
print('c')
while True:
    print('d')
    mainCount = sensor1.distance * 100
    print('e')
    trashCount = sensor2.distance * 100
    print('f')
    recycleCount = sensor3.distance * 100
    print('g')
    print('main: ' + str(mainCount))
    print('trash: ' + str(trashCount))
    print('recycling: ' + str(recycleCount))
    time.sleep(1)