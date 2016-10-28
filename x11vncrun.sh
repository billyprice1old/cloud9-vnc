if [-f ~/.vnc/passwd ]; then
    sudo x11vnc -shared -rfbport 5900 -display :99 -usepw
    exit
else
    x11vnc -shared -rfbport 5900 -display :99
    exit
fi