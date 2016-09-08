#! /bin/bash

#===================================================#
# Configuration of DSS on the edge node				#
#===================================================#

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Global update of the machine
gpg --keyserver pgp.mit.edu --recv-keys B9733A7A07513CAD
gpg -a --export 07513CAD | apt-key add -
apt-get -y update
apt-get -y upgrade