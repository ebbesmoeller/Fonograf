#!/usr/bin/env python
import os, subprocess, pipes, json, select
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer

serverPort = 40000
secret = 'dbacb7e96b1d1d1d8542b389e836e7ccee3a66b0'
tempDir = '/tmp/musicPlayer'
pipeFile = '/tmp/musicPlayer/pipe'
playlistFile = '/tmp/musicPlayer/playlist'

os.system('mkdir '+tempDir)
os.system('touch '+playlistFile)
os.system('cat /dev/null > '+playlistFile)
os.system('mkfifo '+pipeFile)
mPlayer = subprocess.Popen(['mplayer','-slave','-quiet','-idle', '-input', 'file='+pipeFile],stdin=subprocess.PIPE, stdout=subprocess.PIPE)

# TOOLS
def mplayerInput(input):
    os.system('echo \''+input+'\' > '+pipeFile)
    return
def mplayerOutput():
    ret = []
    while any(select.select([mPlayer.stdout.fileno()], [], [], 0.6)):
        ret.append( mPlayer.stdout.readline() )
    return ret
def cleanFilePath(path):
    path = path.replace("'", "'\\''")
    path = path.replace('"', '"\\""')
    return path

# PLAYER FUNCTIONS
def playing():
    mplayerInput('chapter')
    print mplayerOutput()
    return

def playFile(file):
    file = cleanFilePath(file)
    mplayerInput('loadfile "'+file+'" 0');
    return

def addToPlaylist(file):
    file = cleanFilePath(file)
    os.system('echo "'+file+'" >> '+playlistFile)
    print 'Adding: '+file
    mplayerInput('loadfile "'+file+'" 1')
    return

# SERVER
def handleRequest(request):
    if request['command'] == 'playFile':
        playFile(request['parameter'])
    elif request['command'] == 'playlistAdd':
        addToPlaylist(request['parameter'])
    elif request['command'] == 'playing':
        playing()
    return

class S(BaseHTTPRequestHandler):
    def do_POST(self):
        length = int(self.headers['Content-Length'])
        request = self.rfile.read(length).decode('utf-8')
        request = json.loads(request)
        if request['secret'] == secret:
            handleRequest(request)
            self.send_response(200)
        else :
            self.send_response(401)

        self.send_header("Content-type", "text/html")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()

def run(server_class=HTTPServer, handler_class=S, port=serverPort):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print 'Starting musicPlayer server'
    print mplayerOutput()
    httpd.serve_forever()

# MAIN LOOP
if __name__ == "__main__":
    from sys import argv
    if len(argv) == 2:
        run(port=int(argv[1]))
    else:
        run()
