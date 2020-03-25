#!/bin/bash
vncpwd=123456
pwdfile=/tmp/.vnc.tmp
vncdisp=3

echo $vncpwd >$pwdfile
echo $vncpwd >>$pwdfile  # note >> for append
vncpasswd <$pwdfile >/tmp/vncpasswd.1 2>/tmp/vncpasswd.2
vncserver -geometry 2400x1350 :$vncdisp 
./noVNC/utils/launch.sh --listen 5901 --vnc localhost:590$vncdisp &

export DISPLAY=:$vncdisp
metacity &
konsole &
emulator @testdevice_api26 -gpu guest &
/tmp/qt-unified-linux-x64-3.2.2-online.run &
sleep 99999999
