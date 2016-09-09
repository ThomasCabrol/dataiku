#! /bin/bash
echo "Doing nothing..."
echo $@ 
echo $@ > /tmp/all-args
echo printenv 
echo printenv > /tmp/all-printenv