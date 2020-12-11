#!/bin/bash

echo "Title=sys_info"
date
uname -a
echo "IP address: $(ip addr show | head -9 | tail -1)"
echo "$(hostname)"
