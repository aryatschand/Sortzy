# ProfHacks
stream1 = os.popen('fswebcam /home/pi/test/Images/image.jpg')
output1 = stream1.read()
mystring1 = ""
lcd.clear()
lcd.message('Converting\nTo B64')

with open("/home/pi/test/Images/image.jpg", "rb") as img_file1:
    my_string1 = base64.b64encode(img_file1.read())
