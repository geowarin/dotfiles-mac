
# Trackpad suspend

https://www.hitarththummar.xyz/posts/touchpadrestart/

Usb auto suspend ?

https://askubuntu.com/a/1118653

```
$ usb-devices
T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#=  8 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=05ac ProdID=0265 Rev=08.55
S:  Manufacturer=Apple Inc.
S:  Product=Magic Trackpad 2
S:  SerialNumber=CC2548304PMGTFQAA
C:  #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
I:  If#=0x1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
I:  If#=0x2 Alt= 0 #EPs= 2 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
I:  If#=0x3 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
```

$ lsusb -v 2> /dev/null | grep "Magic Trackpad 2" -A 30
Bus 001 Device 006: ID 05ac:0265 Apple, Inc. Magic Trackpad 2
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x05ac Apple, Inc.
  idProduct          0x0265 
  bcdDevice            8.55
  iManufacturer           1 Apple Inc.
  iProduct                2 Magic Trackpad 2
  iSerial                 3 CC2548304PMGTFQAA
  bNumConfigurations      1


$ sudo grep 0265  /sys/bus/usb/devices/*/idProduct
/sys/bus/usb/devices/1-3.4/idProduct:0265

https://unix.stackexchange.com/questions/131422/touchpad-doesnt-wake-up-from-suspend
https://hamwaves.com/usb.autosuspend/en/
https://wiki.archlinux.org/index.php/Power_management#USB_autosuspend

cat /sys/bus/usb/devices/1-3.4/power/control 
on

means no autosuspend
Wrong track

---

https://unix.stackexchange.com/a/342953

cat /sys/module/usbcore/parameters/autosuspend
-1


---

```
TID=$(xinput list | grep -iPo 'touchpad.*id=\K\d+')
xinput disable "$TID"
xinput enable "$TID"
```


https://askubuntu.com/questions/1124045/touchpad-scroll-not-working-properly-after-suspend