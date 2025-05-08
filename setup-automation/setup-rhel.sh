#!/bin/bash

# Create an output file
touch /root/post-run.log

# register host
subscription-manager config --rhsm.manage_repos=1
subscription-manager register --org=12451665 --activationkey=${ACTIVATION_KEY} --force

# Create a done file to signal we have finished
touch /root/post-run.log.done

tee -a /root/node-app-server.toml << EOF
name = "node-app-server"
description = "Sample image for the node.js application server"
version = "0.0.1"
modules = []
groups = []
EOF

#set up tmux so it has to restart itself whenever the system reboots

#step 1: make a script
tee ~/startup-tmux.sh << EOF
TMUX='' tmux new-session -d -s 'rhel-session' > /dev/null 2>&1
tmux set -g pane-border-status top
tmux setw -g pane-border-format ' #{pane_index} #{pane_current_command}'
tmux set -g mouse on
tmux set mouse on
EOF

#step 2: make it executable
chmod +x ~/startup-tmux.sh
#step 3: use cron to execute 
echo "@reboot ~/startup-tmux.sh" | crontab -

#step 4: start tmux for the lab
~/startup-tmux.sh