#! /bin/bash

INRES="3840x2160"
FPS="30"

#OUTRES="1920x1079"
#QUAL="medium"
# If you have low bandwidth, put the qual preset on 'fast' (upload bandwidth)
# If you have medium bandwitch put it on normal to medium

ffmpeg \
    -f x11grab -s $INRES  -r "$FPS" -re -i :1.0  -c:v libvpx\
    -f alsa -ac 2 -i pulse \
    http://localhost:8090/feed1.ffm

#    -vcodec libx264 -s $OUTRES -preset $QUAL \
#    -acodec aac -ar 44100 -b:a 128k -bufsize 512k \
