#!/bin/bash

# Create an output file
# Unregister and register the VM
subscription-manager clean
subscription-manager register --activationkey=12-5-22-instruqt --org=12451665 --force

touch /root/post-run.log

# Create a done file to signal we have finished
touch /root/post-run.log.done

tee -a /root/node-app-server.toml << EOF
name = "node-app-server"
description = "Sample image for the node.js application server"
version = "0.0.1"
modules = []
groups = []
EOF