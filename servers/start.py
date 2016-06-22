#!/usr/bin/env python
import subprocess, threading, sys, os, inspect
from threading import Thread

baseDir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))

class startProcess (threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
        subprocess.Popen([baseDir+'/musicPlayer.py'])
        subprocess.Popen([baseDir+'/ledServer.py'])

# MAIN LOOP
def main(args):
    print('Starting servers')
    start = startProcess()
    start.daemon = True
    start.start()

if __name__ == "__main__":
    main(sys.argv)
