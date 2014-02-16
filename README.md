# local-chromecast: Casting local media on a Google ChromeCast

## Synposis

This project allows one to watch local media (I have only been successful with mp3 and mp4 files NOT avi ones) by streaming it to a Google ChromeCast present on the local network. The video is streamed at approximately 650 kbps at which speed the video quality is excellent.

NOTE: This does NOT require any hacking of the ChromeCast or registration with the Google backend. Simply set this project up on an Ubuntu computer which has Chrome and the Google Cast Chrome Extension installed and it will work.

## Genesis 

The project is basically a modification of the "HelloVideos" project provided by the Google team to aid Developers. I have used their code to create a python application which is served via uwsgi and nginx which reads and displays files from a specific "media" folder and allows one to cast a selected file to a ChromeCast operating on the same WiFi network.

## Supported Media formats

I have ONLY had success with mp3 and mp4 files. In particular I was unable to play avi files using this technique probably because HTML5 (which is what the ChromeCast uses) has no avi support in any browser.

## Installation

The project comes with a Makefile which can be used to install and run it. Simply navigate to the project root folder and issue:
    
    sudo make install       # Sets up the project
    sudo make start         # (re)starts the uwsgi and nginx services
    make run                # Launches the Controller page in Chrome
