#!/usr/bin/env python
import sys, inspect, cgi, os, subprocess, pipes, json, select, time, threading
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
from urlparse import parse_qs
from threading import Thread

# SETTINGS
serverPort = 40000
baseDir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
tempDir = '/tmp/musicPlayer'
secret = 'dbacb7e96b1d1d1d8542b389e836e7ccee3a66b0'
playlistFile = '/tmp/musicPlayer/playlist'

# TOOLS
def cleanFilePath(path):
    path = path.replace("'", "\\'")
    path = path.replace('"', '\\"')
    # path = path.replace(' ', '\\ ')
    return path

# CLASSES
class MPlayer(object):
    exe_name = 'mplayer' if os.sep == '/' else 'mplayer.exe'
    def __init__(self):
        self._mplayer = subprocess.Popen(
                [self.exe_name, '-slave', '-quiet', '-idle'],
                stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1)
        self._readlines()
    def _readlines(self):
        ret = []
        while any(select.select([self._mplayer.stdout.fileno()], [], [], 0.1)):
            ret.append( self._mplayer.stdout.readline() )
        return ret
    def command(self, name, *args):
        cmd = '%s%s%s\n'%(name,
                ' ' if args else '',
                ' '.join(repr(a) for a in args)
                )
        self._mplayer.stdin.write(cmd)
        if name == 'quit':
            return
        return self._readlines()
    def commandNoReturn(self, name, *args):
        cmd = '%s%s%s\n'%(name,
                ' ' if args else '',
                ' '.join(repr(a) for a in args)
                )
        self._mplayer.stdin.write(cmd)
        return
class musicPlayer (threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
        self.kill = False
        self.mPlayer = MPlayer()
        self.currentlyPlaying = ''
        self.playlistCount = 0
        self.currentIndex = 0
        self.loopingPlayback = False
        self.volume = 45
        self.pause = False
        self.mute = False
    def run(self):
        time.sleep(3)
        self.setVolume(self.volume)
        self.mPlayer.command('loadfile "'+baseDir+'/../effects/start.mp3"')
        while not self.kill:
            self.playlister()
    def playlister(self):
        noCount = 0
        while noCount < 5:
            if not self.mPlayer.command('get_percent_pos'):
                noCount = noCount + 1

        noCount = 0
        self.currentlyPlaying = ''
        lines = [line.rstrip('\n') for line in open(playlistFile)]
        if lines:
            if 0 <= self.currentIndex < len(lines):
                file = lines[self.currentIndex]
                print('Playing: '+file)
                self.currentlyPlaying = file
                self.mPlayer.commandNoReturn('loadfile "'+cleanFilePath(file)+'"')
                self.currentIndex = self.currentIndex+1
            else:
                if self.loopingPlayback:
                    self.currentIndex = 0
                self.currentlyPlaying = ''
        time.sleep(0.1)

    def setPause(self):
        self.mPlayer.commandNoReturn('pause')
        if self.pause:
            print 'Unpaused'
            self.pause = False
        elif not self.pause:
            print 'Paused'
            self.pause = True
    def setMute(self):
        self.mPlayer.commandNoReturn('mute')
        if self.mute:
            print 'Unmuted'
            self.mute = False
        elif not self.mute:
            print 'Muted'
            self.mute = True
    def skipToIndex(self, index):
        self.mPlayer.commandNoReturn('stop')
        self.currentIndex = int(index)
    def setPrevTrack(self):
        if self.currentlyPlaying != '':
            newIndex = self.currentIndex-2
            if newIndex >= 0:
                self.skipToIndex(newIndex)
    def setNextTrack(self):
        if self.currentlyPlaying != '':
            if self.currentIndex <= self.playlistCount-1:
                self.skipToIndex(self.currentIndex)
    def setVolume(self, percentage):
        self.volume = int(percentage)
        self.mPlayer.commandNoReturn('set volume '+str(percentage))
    def currentPlaylist(self):
        return [line.rstrip('\n') for line in open(playlistFile)]
    def addToPlaylist(self, file):
        if os.path.isfile(file):
            self.playlistCount = self.playlistCount+1
            print('Adding: '+file)
            os.system('echo "'+file+'" >> '+playlistFile)
        return
    def playerState(self):
        indexNumber = self.currentIndex-1
        if self.currentIndex < 0:
            indexNumber = 0
        state = [
            {
            'pause': self.pause,
            'mute': self.mute,
            'playing': self.currentlyPlaying,
            'index': indexNumber,
            'loop': self.loopingPlayback,
            'volume': self.volume
            },
        ]
        return state[0]

#SETUP
if not os.path.isdir(tempDir):
    os.system('mkdir '+tempDir)
    os.system('touch '+playlistFile)
os.system('cat /dev/null > '+playlistFile)
music = musicPlayer()
music.daemon = True

# SERVER
def handleRequest(request):
    command = ''
    if 'command' in request:
        command = request['command'][0]

    value = ''
    if 'value' in request:
        value = request['value'][0]

    if command == 'playlistAdd':
        music.addToPlaylist(value)
    elif command == 'playlist':
        return json.dumps(music.currentPlaylist())
    elif command == 'setPause':
        Thread(target=music.setPause, args=()).start()
    elif command == 'setMute':
        Thread(target=music.setMute, args=()).start()
    elif command == 'setPrevTrack':
        Thread(target=music.setPrevTrack, args=()).start()
    elif command == 'setNextTrack':
        Thread(target=music.setNextTrack, args=()).start()
    elif command == 'skipToIndex':
        Thread(target=music.skipToIndex, args=(int(value), )).start()
    elif command == 'setVolume':
        Thread(target=music.setVolume, args=(value, )).start()
    elif command == 'playerState':
        return json.dumps(music.playerState())
    return

class S(BaseHTTPRequestHandler):
    def do_GET(self):
        requestData = parse_qs(self.path[2:])
        if requestData:
            if requestData['secret'][0] == secret:
                returnData = handleRequest(requestData)
                self.send_response(200)
            else :
                self.send_response(401)
        else:
            self.send_response(404)

        self.send_header("Content-type", "application/json")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()

        if returnData:
            self.wfile.write(returnData)

    def do_POST(self):
        requestData = parse_qs(self.path[2:])
        if requestData:
            if requestData['secret'][0] == secret:
                handleRequest(requestData)
                self.send_response(200)
            else :
                self.send_response(401)
        else:
            self.send_response(404)

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
    print('Starting musicplayer')
    music.start()

    from sys import argv
    if len(argv) == 2:
        run(port=int(argv[1]))
    else:
        run()

if __name__ == "__main__":
    main(sys.argv)
