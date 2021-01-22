

## Blacklist HDMI audio

Added this in `/etc/pulse/default.pa`:


```conf
# gwa: disable nvidia HDMI
set-card-profile alsa_card.pci-0000_01_00.1 off
```

==> does not work after suspend

## Firefox refresh rate

about:config
layout.frame_rate = 120

layers.acceleration.force-enabled = true


## DDC with ddcutil

Manually:

```
sudo modprobe i2c-dev
sudo chmod a+rw /dev/i2c-*
```

Automatically:


```
sudo sh -c "echo i2c-dev > /etc/modules-load.d/i2c-dev.conf"
sudo groupadd --system i2c
sudo usermod geowarin -aG i2c
sudo cp /usr/share/ddcutil/data/45-ddcutil-i2c.rules /etc/udev/rules.d
```



## TODO

### polkit with code:

Failed to save 'default.pa': 
Command failed: cd "/home/geowarin/dev"; "/usr/bin/pkexec" 
--disable-internal-agent /bin/bash -c "echo SUDOPROMPT; 
\"/usr/lib/electron9/bin/code-oss\" --file-write 
\"/home/geowarin/.config/Code - OSS/code-elevated-nhslva\" 
\"/etc/pulse/default.pa\"" /bin/bash:
 line 1: /usr/lib/electron9/bin/code-oss: No such file or directory

 https://wiki.archlinux.org/index.php/Polkit#Authentication_agents


### Thunar thumbnails

https://docs.xfce.org/xfce/tumbler/available_plugins

yay -Si aur/f3d