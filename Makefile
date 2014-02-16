# Author: Abid H. Mujtaba
# Email: abid.naqvi83@gmail.com
# Date: 2014-02-15

# This Makefile sets up the local-chromecast project by installing nginx, uwsgi and jinja2 (pip) if required and by placing config files in the correct locations.

# Variables

# The port on which nginx serves the application. 3435 is the only non-trivial Munchausen number.
PORT=3435
# The IP Address of the computer (server) on the Wireless network. Leave empty if you want the script to determine this automatically.
HOST=


# Declare PHONY targets
.PHONY: run, start, install

# Define targets
run:					# Launches the application in Chrome
	/usr/bin/google-chrome http://localhost:$(PORT)

start:					# (re)starts the uwsgi and nginx services. Needs to be run as root (using sudo)
	service uwsgi restart
	service nginx restart

install:				# Installs (sets up) the project. Needs to be run as root (using sudo)

	apt-get install nginx
	apt-get install uwsgi
	apt-get install uwsgi-plugin-python

# Install the jinja2 module for python
	pip install Jinja2

# Store the current working directory in CWD. This will be used to ensure that the symlinks and application point to the correct location.
	$(eval CWD := $(shell pwd))
# Get IP address on Wireless network by parsing output of ifconfig
	$(eval HOST := $(shell ifconfig wlan0 | grep "inet addr" | cut -d: -f2 | cut -d' ' -f1))
# Add one to PORT to get the uwsgi port
	$(eval PORT2 := $(shell echo $(PORT) + 1 | bc))

# Create subfolders for Media and generated files (where template variables are replaced by calculated values)
	mkdir -p media
	mkdir -p build/config

# Copy (template) application and configuration files to the build folder and then use sed to replace place-holders with the calculated working directory, port and host ip address
	cp app.py build/
	sed -i -e 's#CWD#$(CWD)#' -e 's#HOST#http://$(HOST):$(PORT)#' build/app.py

	cp config/* build/config/
# Substitute PORT2 before PORT because the latter will change the PORT part of PORT2
	sed -i -e 's#PORT2#$(PORT2)#' build/config/*
	sed -i -e 's#PORT#$(PORT)#' -e 's#CWD#$(CWD)#' build/config/* 
	
# Place symlinks to config files in nginx and uwsgi default locations for automatic configuration
	ln -sf $(CWD)/build/config/nginx_local-chromecast.conf /etc/nginx/sites-enabled/
	ln -sf $(CWD)/build/config/uwsgi_local-chromecast.ini /etc/uwsgi/apps-enabled/
