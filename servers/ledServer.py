#!/usr/bin/env python
import sys, inspect, cgi, os, subprocess, pipes, json, select, time, threading
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
from urlparse import parse_qs
from threading import Thread
from gpiozero import RGBLED
from gpiozero import PWMLED

# SETTINGS
serverPort = 40001
baseDir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
secret = '4468e5deabf5e6d0740cd1a77df56f67093ec943'

# TOOLS
def cleanColor(color):
    color = color.replace("#", "")
    color = color[:6]
    return color

# CLASSES
class ledControl(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
        self.color = '000000'
        self.red = 0
        self.green = 0
        self.blue = 0

        self.bRed = 0.4
        self.bGreen = 0
        self.bBlue = 0

        self.on = True
        self.blink = False
        self.RGB = RGBLED(22,23,24,False,(self.bRed, self.bGreen, self.bBlue))
    def convertColor(self):
        try:
            divider     = 256
            red         = float(int("0x"+self.color[0:2], 0))
            # red         = red-(red/2)

            green       = float(int("0x"+self.color[2:4], 0))
            green       = green-(green/2.5)

            blue        = float(int("0x"+self.color[4:6], 0))
            # blue        = blue-(blue/2)
            if red>=divider:
               red=divider
            if green>=divider:
               green=divider
            if blue>=divider:
               blue=divider
            self.red = red/divider
            self.green = green/divider
            self.blue = blue/divider
            return True
        except ValueError:
            return False
    def setColor(self, red, green, blue):
        self.RGB.color = (red,green,blue)
    def setHexColor(self, color):
        self.color = cleanColor(color)
        return self.convertColor()
    def loadAndSetColor(self, color):
        self.color = cleanColor(color)
        self.convertColor()
        self.setColor(self.red, self.green, self.blue)
        return
    def blinkLeds(self, interval, fadeTime, blinks, on):
        if not self.blink:
            Thread(target=self.blinkingThread, args=(interval,fadeTime,blinks,on, )).start()
            return True
        return False
    def blinkingThread(self, interval, fadeTime, blinks, on):
        fInterval = float(interval)
        fFadeTime = float(fadeTime)
        fBlinks = int(blinks)
        if not self.blink:
            self.blink = True
            blinker = self.RGB.blink(fInterval, fInterval, fFadeTime, fFadeTime, (self.red, self.green, self.blue), (self.bRed, self.bGreen, self.bBlue), fBlinks, False)
            self.blink = False
            blinker = None
        if on:
            self.setColor(self.red,self.green,self.blue)
        else:
            self.setColor(self.bRed, self.bGreen, self.bBlue)
    def rainbow(self):
        self.loadAndSetColor('#000000')
        time.sleep(0.5)
        self.loadAndSetColor('#110000')
        time.sleep(0.05)
        self.loadAndSetColor('#220000')
        time.sleep(0.05)
        self.loadAndSetColor('#330000')
        time.sleep(0.05)
        self.loadAndSetColor('#440000')
        time.sleep(0.05)
        self.loadAndSetColor('#550000')
        time.sleep(0.05)
        self.loadAndSetColor('#660000')
        time.sleep(0.05)
        self.loadAndSetColor('#770000')
        time.sleep(0.05)
        self.loadAndSetColor('#880000')
        time.sleep(0.05)
        self.loadAndSetColor('#990000')
        time.sleep(0.05)
        self.loadAndSetColor('#AA0000')
        time.sleep(0.05)
        self.loadAndSetColor('#BB0000')
        time.sleep(0.05)
        self.loadAndSetColor('#CC0000')
        time.sleep(0.05)
        self.loadAndSetColor('#DD0000')
        time.sleep(0.05)
        self.loadAndSetColor('#EE0000')
        time.sleep(0.05)
        self.loadAndSetColor('#FF0000')
        time.sleep(0.05)
        self.loadAndSetColor('#FF1100')
        time.sleep(0.05)
        self.loadAndSetColor('#FF2200')
        time.sleep(0.05)
        self.loadAndSetColor('#FF3300')
        time.sleep(0.05)
        self.loadAndSetColor('#FF4400')
        time.sleep(0.05)
        self.loadAndSetColor('#FF5500')
        time.sleep(0.05)
        self.loadAndSetColor('#FF6600')
        time.sleep(0.05)
        self.loadAndSetColor('#FF7700')
        time.sleep(0.05)
        self.loadAndSetColor('#FF8800')
        time.sleep(0.05)
        self.loadAndSetColor('#FF9900')
        time.sleep(0.05)
        self.loadAndSetColor('#FFAA00')
        time.sleep(0.05)
        self.loadAndSetColor('#FFBB00')
        time.sleep(0.05)
        self.loadAndSetColor('#FFCC00')
        time.sleep(0.05)
        self.loadAndSetColor('#FFDD00')
        time.sleep(0.05)
        self.loadAndSetColor('#FFEE00')
        time.sleep(0.05)
        self.loadAndSetColor('#FFFF00')
        time.sleep(0.05)
        self.loadAndSetColor('#EEFF00')
        time.sleep(0.05)
        self.loadAndSetColor('#DDFF00')
        time.sleep(0.05)
        self.loadAndSetColor('#CCFF00')
        time.sleep(0.05)
        self.loadAndSetColor('#BBFF00')
        time.sleep(0.05)
        self.loadAndSetColor('#AAFF00')
        time.sleep(0.05)
        self.loadAndSetColor('#AAFF00')
        time.sleep(0.05)
        self.loadAndSetColor('#99FF00')
        time.sleep(0.05)
        self.loadAndSetColor('#88FF00')
        time.sleep(0.05)
        self.loadAndSetColor('#77FF00')
        time.sleep(0.05)
        self.loadAndSetColor('#66FF00')
        time.sleep(0.05)
        self.loadAndSetColor('#55FF00')
        time.sleep(0.05)
        self.loadAndSetColor('#44FF00')
        time.sleep(0.05)
        self.loadAndSetColor('#33FF00')
        time.sleep(0.05)
        self.loadAndSetColor('#22FF00')
        time.sleep(0.05)
        self.loadAndSetColor('#11FF00')
        time.sleep(0.05)
        self.loadAndSetColor('#00FF00')
        time.sleep(0.05)
        self.loadAndSetColor('#00FF11')
        time.sleep(0.05)
        self.loadAndSetColor('#00FF22')
        time.sleep(0.05)
        self.loadAndSetColor('#00FF33')
        time.sleep(0.05)
        self.loadAndSetColor('#00FF44')
        time.sleep(0.05)
        self.loadAndSetColor('#00FF55')
        time.sleep(0.05)
        self.loadAndSetColor('#00FF66')
        time.sleep(0.05)
        self.loadAndSetColor('#00FF77')
        time.sleep(0.05)
        self.loadAndSetColor('#00FF88')
        time.sleep(0.05)
        self.loadAndSetColor('#00FF99')
        time.sleep(0.05)
        self.loadAndSetColor('#00FFAA')
        time.sleep(0.05)
        self.loadAndSetColor('#00FFBB')
        time.sleep(0.05)
        self.loadAndSetColor('#00FFCC')
        time.sleep(0.05)
        self.loadAndSetColor('#00FFEE')
        time.sleep(0.05)
        self.loadAndSetColor('#00FFFF')
        time.sleep(0.05)
        self.loadAndSetColor('#00EEFF')
        time.sleep(0.05)
        self.loadAndSetColor('#00DDFF')
        time.sleep(0.05)
        self.loadAndSetColor('#00CCFF')
        time.sleep(0.05)
        self.loadAndSetColor('#00BBFF')
        time.sleep(0.05)
        self.loadAndSetColor('#00AAFF')
        time.sleep(0.05)
        self.loadAndSetColor('#0099FF')
        time.sleep(0.05)
        self.loadAndSetColor('#0088FF')
        time.sleep(0.05)
        self.loadAndSetColor('#0077FF')
        time.sleep(0.05)
        self.loadAndSetColor('#0066FF')
        time.sleep(0.05)
        self.loadAndSetColor('#0055FF')
        time.sleep(0.05)
        self.loadAndSetColor('#0044FF')
        time.sleep(0.05)
        self.loadAndSetColor('#0033FF')
        time.sleep(0.05)
        self.loadAndSetColor('#0022FF')
        time.sleep(0.05)
        self.loadAndSetColor('#0011FF')
        time.sleep(0.05)
        self.loadAndSetColor('#0000FF')
        time.sleep(0.05)
        self.loadAndSetColor('#1100FF')
        time.sleep(0.05)
        self.loadAndSetColor('#2200FF')
        time.sleep(0.05)
        self.loadAndSetColor('#3300FF')
        time.sleep(0.05)
        self.loadAndSetColor('#4400FF')
        time.sleep(0.05)
        self.loadAndSetColor('#5500FF')
        time.sleep(0.05)
        self.loadAndSetColor('#6600FF')
        time.sleep(0.05)
        self.loadAndSetColor('#7700FF')
        time.sleep(0.05)
        self.loadAndSetColor('#8800FF')
        time.sleep(0.05)
        self.loadAndSetColor('#9900FF')
        time.sleep(0.05)
        self.loadAndSetColor('#AA00FF')
        time.sleep(0.05)
        self.loadAndSetColor('#BB00FF')
        time.sleep(0.05)
        self.loadAndSetColor('#CC00FF')
        time.sleep(0.05)
        self.loadAndSetColor('#DD00FF')
        time.sleep(0.05)
        self.loadAndSetColor('#EE00FF')
        time.sleep(0.05)
        self.loadAndSetColor('#FF00FF')
        time.sleep(0.05)
        self.loadAndSetColor('#FF00EE')
        time.sleep(0.05)
        self.loadAndSetColor('#FF00DD')
        time.sleep(0.05)
        self.loadAndSetColor('#FF00CC')
        time.sleep(0.05)
        self.loadAndSetColor('#FF00BB')
        time.sleep(0.05)
        self.loadAndSetColor('#FF00AA')
        time.sleep(0.05)
        self.loadAndSetColor('#FF0099')
        time.sleep(0.05)
        self.loadAndSetColor('#FF0088')
        time.sleep(0.05)
        self.loadAndSetColor('#FF0077')
        time.sleep(0.05)
        self.loadAndSetColor('#FF0066')
        time.sleep(0.05)
        self.loadAndSetColor('#FF0055')
        time.sleep(0.05)
        self.loadAndSetColor('#FF0044')
        time.sleep(0.05)
        self.loadAndSetColor('#FF0033')
        time.sleep(0.05)
        self.loadAndSetColor('#FF0022')
        time.sleep(0.05)
        self.loadAndSetColor('#FF0011')
        time.sleep(0.05)
        self.loadAndSetColor('#FF0000')
        time.sleep(0.05)
        self.loadAndSetColor('#EE0000')
        time.sleep(0.05)
        self.loadAndSetColor('#DD0000')
        time.sleep(0.05)
        self.loadAndSetColor('#CC0000')
        time.sleep(0.05)
        self.loadAndSetColor('#BB0000')
        time.sleep(0.05)
        self.loadAndSetColor('#AA0000')
        time.sleep(0.05)
        self.loadAndSetColor('#990000')
        time.sleep(0.05)
        self.loadAndSetColor('#880000')
        time.sleep(0.05)
        self.loadAndSetColor('#770000')
        time.sleep(0.05)
        self.loadAndSetColor('#660000')
        time.sleep(0.05)
        self.loadAndSetColor('#550000')
        time.sleep(0.05)
        self.loadAndSetColor('#440000')
        time.sleep(0.05)
        self.loadAndSetColor('#330000')
        time.sleep(0.05)
        self.loadAndSetColor('#220000')
        time.sleep(0.05)
        self.loadAndSetColor('#110000')
        time.sleep(0.05)
        self.loadAndSetColor('#000000')
        time.sleep(0.5)
        self.setColor(0.4,0,0)

#SETUP
leds = ledControl()
leds.daemon = True
leds.setHexColor('#00ff00')
leds.blinkLeds(0,0.3,5,False)


# SERVER
def handleRequest(request):
    command = ''
    if 'command' in request:
        command = request['command'][0]

    value = ''
    if 'value' in request:
        value = request['value'][0]

    if command == 'loadSetColor':
        return leds.loadAndSetColor(value)
    elif command == 'setHexColor':
        return leds.setHexColor(value)
    elif command == 'blinkLeds':
        try:
            values = json.loads(value)
            interval = float(values['interval'])
            fadeTime = float(values['fadeTime'])
            blinks = int(values['blinks'])
            if values['on']:
                on = True
            elif not values['on']:
                on = False
            return leds.blinkLeds(interval,fadeTime,blinks,on)
        except KeyError:
            return False
    elif command == 'rainbow':
        Thread(target=leds.rainbow, args=()).start()
    return

class S(BaseHTTPRequestHandler):
    def do_GET(self):
        try:
            requestData = parse_qs(self.path[2:])
            returnData = None
            if requestData:
                if requestData['secret'][0] == secret:
                    returnData = handleRequest(requestData)
                    self.send_response(200)
                else :
                    self.send_response(401)
            else:
                self.send_response(404)
        except KeyError:
            self.send_response(500)

        self.send_header("Content-type", "application/json")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()

        if returnData:
            self.wfile.write(returnData)

    def do_POST(self):
        try:
            requestData = parse_qs(self.path[2:])
            if requestData:
                if requestData['secret'][0] == secret:
                    handleRequest(requestData)
                    self.send_response(200)
                else :
                    self.send_response(401)
            else:
                self.send_response(404)
        except KeyError:
            self.send_response(500)

        self.send_header("Content-type", "application/json")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()

def run(server_class=HTTPServer, handler_class=S, port=serverPort):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print('Starting server')
    httpd.serve_forever()

# MAIN LOOP
def main(args):
    from sys import argv
    if len(argv) == 2:
        run(port=int(argv[1]))
    else:
        run()

if __name__ == "__main__":
    main(sys.argv)
