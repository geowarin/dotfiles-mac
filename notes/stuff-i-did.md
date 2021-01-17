

## Blacklist HDMI audio

Added this in `/etc/pulse/default.pa`:


```conf
# gwa: disable nvidia HDMI
set-card-profile alsa_card.pci-0000_01_00.1 off
```



## TODO

Failed to save 'default.pa': 
Command failed: cd "/home/geowarin/dev"; "/usr/bin/pkexec" 
--disable-internal-agent /bin/bash -c "echo SUDOPROMPT; 
\"/usr/lib/electron9/bin/code-oss\" --file-write 
\"/home/geowarin/.config/Code - OSS/code-elevated-nhslva\" 
\"/etc/pulse/default.pa\"" /bin/bash:
 line 1: /usr/lib/electron9/bin/code-oss: No such file or directory