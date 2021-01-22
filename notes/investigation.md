
# Trackpad suspend

https://unix.stackexchange.com/questions/131422/touchpad-doesnt-wake-up-from-suspend


```
TID=$(xinput list | grep -iPo 'touchpad.*id=\K\d+')
xinput disable "$TID"
xinput enable "$TID"
```


https://askubuntu.com/questions/1124045/touchpad-scroll-not-working-properly-after-suspend