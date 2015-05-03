#!/bin/sh
# @Author: bbales
# @Date:   2015-05-03 11:47:28
# @Last Modified by:   bbales
# @Last Modified time: 2015-05-03 14:03:07

while true; do
    curl 192.168.4.1/a:$(date +%s)
    # this was optimal
    # 0.015 - 0.02 works well
    sleep 0.018
done