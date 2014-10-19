#
# NodeBB Dockerfile
#
# https://github.com/Morphy2k/docker-nodebb
#

# Pull base image.
FROM node:slim

MAINTAINER Markus Wiegand <mail@morphy.info>

# Install packages
RUN apt-get update
RUN apt-get install imagemagick -y
	
# Install NodeBB
RUN \	
	git clone -b v0.5.x https://github.com/NodeBB/NodeBB.git /nodebb && \
	cd /nodebb && \
	npm install --production
	
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*

# Add files.
ADD run /nodebb-start

# Define mountable directories.
VOLUME ["/nodebb", "/nodebb-override"]

# Define working directory.
WORKDIR /nodebb

# Define default command.
CMD ["bash", "/nodebb-start"]

# Expose ports.
EXPOSE 4567
