#!/bin/bash

echo VNC client running at https://$C9_HOSTNAME/vnc.html
echo

cd /home/ubuntu/workspace
supervisord -c supervisord.conf