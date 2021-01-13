---
title: manjaro
created: '2020-12-18T12:43:02.567Z'
modified: '2020-12-20T15:54:13.108Z'
---

# I installed Manjaro

## Default audio


https://askubuntu.com/questions/71863/how-to-change-pulseaudio-sink-with-pacmd-set-default-sink-during-playback/72076#72076

https://forum.manjaro.org/t/my-default-audio-device-gets-swapped-every-time-my-computer-sleeps/32267/3

![Screenshot_20201218_141137.png](/home/geowarin/Pictures/Screenshot_20201218_141137.png)

hdmi-output-0 <- wrong (dell hdmi)
hdmi-output-1 <- OK (DP2)

/etc/pulse/default.pa

pacmd set-sink-port alsa_output.pci-0000_01_00.1.hdmi-stereo hdmi-output-0 ??

.config/pulse/


WRONG:

```
1 sink(s) available.
  * index: 79
        name: <alsa_output.pci-0000_01_00.1.hdmi-stereo>
...
   ports:
                hdmi-output-0: HDMI / DisplayPort (priority 5900, latency offset 0 usec, available: yes)
                        properties:
                                device.icon_name = "video-display"
                                device.product.name = "DELL U2414H
```

RIGHT:

```
1 sink(s) available.
  * index: 81
        name: <alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1>

ports:
                hdmi-output-1: HDMI / DisplayPort 2 (priority 5800, latency offset 0 usec, available: yes)
                        properties:
                                device.icon_name = "video-display"
                                device.product.name = "LG QHD

```

## Xow

```bash
sudo systemctl enable xow
sudo systemctl start xow
systemctl status xow
journalctl -u xow -f
```

## DDC

https://forums.developer.nvidia.com/t/survey-gddccontrol-issues-with-nvidia-drivers-i2c-monitor-display-ddc/63901/19

kate /etc/X11/xorg.conf.d/90-mhwd.conf

```patch
Section "Device"
    Identifier     "Device0"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
	Option "NoLogo" "1"
+	Option     "RegistryDwords"  "RMUseSwI2c=0x01; RMI2cSpeed=100"
EndSection
```


```
grep RegistryDwords /var/log/Xorg.0.log
[     3.849] (**) NVIDIA(0): Option "RegistryDwords" "RMUseSwI2c=0x01; RMI2cSpeed=100"
```

sudo modprobe i2c-dev

## Pamac

```bash
pamac
pamac info yay
pamac uninstall yay
```

## Sleep freeze

https://mattjones.tech/2020/01/08/how-to-add-swap-in-manjaro/

Not fixed for now

xrandr --output HDMI-0 --right-of DP-2

## Previews via mime types

Example of [markdown preview](https://github.com/oberon-manjaro/markdown_previewer/blob/master/archlinux/markdown_previewer.desktop)

![Screenshot_20201218_135127.png](/home/geowarin/Pictures/Screenshot_20201218_135127.png)

## Weird screen latency

Disabled advanced freesync on my LG monitor

Enabled opengl3 in `Settings > Display and monitor > Compositor`

![Screenshot_20201218_135833.png](/home/geowarin/Pictures/Screenshot_20201218_135833.png)

## Not so good

* Cannot copy paste images from clipboard :(
* 

## Jetbrains toolbox

https://youtrack.jetbrains.com/issue/TBX-3948#focus=Comments-27-3707432.0-0

Fixed in 1.20

/home/geowarin/.local/bin

## Writing Krunner plugins

Via DBUS

Examples:

* [typescript](https://github.com/b-hass/krunner-zeal-plugin/blob/master/install.sh)
* [python](https://github.com/MartijnVogelaar/krunner-spotify/blob/main/install.sh)

https://store.kde.org/browse/cat/630/ord/rating/

## Snaps, Flatpak, AUR...

https://www.fosslinux.com/42410/snap-vs-flatpak-vs-appimage-know-the-differences-which-is-better.htm

* Self-contained: packages all deps
* sandboxed

### Snap
Canonical (Ubuntu)
https://snapcraft.io/

### Flatpak
Independant (multiple repos)
https://flathub.org/home

### AppImage



## Java

https://wiki.archlinux.org/index.php/Java

`archlinux-java` command is awesome

## Great

* pamac
* Krunner
* Spectacle (screenshots) meta + shift + print screen
