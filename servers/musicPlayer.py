#!/usr/bin/env python
import subprocess
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer

def playInMplayer(file):
    subprocess.Popen(['mplayer','-slave','-quiet', file])
    return

class S(BaseHTTPRequestHandler):
    def do_POST(self):
        length = int(self.headers['Content-Length'])
        file = self.rfile.read(length).decode('utf-8')
        playInMplayer(file)
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()

def run(server_class=HTTPServer, handler_class=S, port=40000):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print 'Starting music player server'
    httpd.serve_forever()

if __name__ == "__main__":
    from sys import argv

    if len(argv) == 2:
        run(port=int(argv[1]))
    else:
        run()
