#!/bin/bash

# Create an output file
touch /root/post-run.log

# Create a done file to signal we have finished
touch /root/post-run.log.done

# add user to the weldr group
sudo usermod -aG weldr rhel

tee -a /home/rhel/node-app-server.toml << EOF
name = "node-app-server"
description = "Sample image for the node.js application server"
version = "0.0.1"
modules = []
groups = []
EOF