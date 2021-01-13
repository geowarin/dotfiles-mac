---
attachments: [Clipboard_2021-01-04-13-22-04.png]
title: nvidia
created: '2020-12-20T04:27:15.501Z'
modified: '2021-01-04T12:37:16.332Z'
---

nvidia-xconfig –twinview
etc/X11/xorg.conf.d/20-nvidia.conf

## Modprobe

Command to load kernel modules

/etc/modprobe.d/mhwd-gpu.conf 
Used by the nvidia driver to blacklist other drivers

##  mhwd

Manjaro Hardware Detection

https://wiki.manjaro.org/index.php/Manjaro_Hardware_Detection_Overview

Detect and installs drivers for the graphic card.

Probably generates /etc/X11/xorg.conf.d

00-keyboard.conf  30-touchpad.conf  90-mhwd.conf

## xorg

Arch default config in /usr/share/X11/xorg.conf.d

## Force composition pipeline

https://www.reddit.com/r/linux_gaming/comments/6voivr/can_anyone_explain_what_force_composition/dm1uz2j/

Fix screen tearing?
Incompatible with gsync

Available in nvidia-settings in advanced mode

![Screenshot_20201220_053340.png](/home/geowarin/Pictures/Screenshot_20201220_053340.png)

## Overriding mhwd settings

Using nvidia-settings to generate /etc/X11/xorg.conf.d/95-nvidia.conf

For xconf (gsync)

Add `nvidia-settings --load-config-only` to `~/.xinitrc` before the last line

```patch
...
+nvidia-settings --load-config-only
exec $(get_session)
```

Allows the setting "sync to Vblank" to be enabled.
We then need to choos to which screen it will be synched to

![](@attachment/Clipboard_2021-01-04-13-22-04.png)

In `~/.nvidia-settings-rc`:

```ini
0/XVideoSyncToDisplayID=DP-2 (line is removed when auto)
```

Sync to vblank details:
https://ubuntuforums.org/showthread.php?t=1537858&p=9636234#post9636234

TLDR


### Sources

https://wiki.archlinux.org/index.php/NVIDIA/Tips_and_tricks
https://wiki.archlinux.org/index.php/NVIDIA
https://wiki.archlinux.org/index.php/Hardware_video_acceleration
https://wiki.manjaro.org/index.php/Simple_fix_for_screen_tearing_-_nVidia


```

~
❯ lsmod | grep nvidia
nvidia_drm             65536  1
nvidia_modeset       1232896  2 nvidia_drm
nvidia              34086912  79 nvidia_modeset
i2c_nvidia_gpu         16384  0
drm_kms_helper        274432  1 nvidia_drm
drm                   569344  4 drm_kms_helper,nvidia_drm

~
❯ sudo dmesg | grep vidia
[sudo] password for geowarin: 
[    2.497784] nvidia: loading out-of-tree module taints kernel.
[    2.497792] nvidia: module license 'NVIDIA' taints kernel.
[    2.546962] nvidia: module verification failed: signature and/or required key missing - tainting kernel
[    2.593923] nvidia-nvlink: Nvlink Core is being initialized, major device number 236
[    2.594320] nvidia 0000:01:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
[    2.819315] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver for UNIX platforms  460.32.03  Sun Dec 27 18:51:11 UTC 2020
[    2.823811] [drm] [nvidia-drm] [GPU ID 0x00000100] Loading driver
[    2.823812] [drm] Initialized nvidia-drm 0.0.0 20160202 for 0000:01:00.0 on minor 0

~
❯ locate arch.conf                                  
/usr/lib/depmod.d/search.conf
/usr/lib/sysctl.d/10-arch.conf
/usr/lib/sysusers.d/arch.conf
/usr/lib/tmpfiles.d/arch.conf
/usr/share/systemd/bootctl/arch.conf

~
❯ cat /etc/modprobe.d/mhwd-gpu.conf 
cat: /etc/modprobe.d/mhwd-gpu.conf: No such file or directory


less /var/log/Xorg.0.log

  [     3.083] (II) Loading sub module "glxserver_nvidia"
  [     3.083] (II) LoadModule: "glxserver_nvidia"
  [     3.083] (WW) Warning, couldn't open module glxserver_nvidia
* [     3.083] (EE) NVIDIA: Failed to load module "glxserver_nvidia" (module does not exist, 0)
* [     3.083] (EE) NVIDIA(0): Failed to initialize the GLX module; please check in your X
  [     3.083] (EE) NVIDIA(0):     log file that the GLX module has been loaded in your X
  [     3.083] (EE) NVIDIA(0):     server, and that the module is the NVIDIA GLX module.  If
  [     3.083] (EE) NVIDIA(0):     you continue to encounter problems, Please try
  [     3.083] (EE) NVIDIA(0):     reinstalling the NVIDIA driver.
  [     3.083] (II) NVIDIA: The X server does not support PRIME Render Offload.


❯ inxi -G     
Graphics:  Device-1: NVIDIA TU102 [GeForce RTX 2080 Ti] driver: nvidia v: 460.32.03 
           Display: x11 server: X.Org 1.20.10 driver: nvidia resolution: 1: 1920x1080~60Hz 2: 2560x1440~60Hz 
           OpenGL: renderer: GeForce RTX 2080 Ti/PCIe/SSE2 v: 4.6.0 NVIDIA 460.32.03 
```

# Xorg

```conf
Section "Monitor"
    # HorizSync source: edid, VertRefresh source: edid
    Identifier     "DP-2"
    VendorName     "Unknown"
    ModelName      "LG Electronics LG QHD"
    HorizSync       30.0 - 230.0
    VertRefresh     50.0 - 144.0
    Option         "DPMS"
    Option      "Primary" "true"
EndSection

Section "Monitor"
    # HorizSync source: edid, VertRefresh source: edid
    Identifier     "HDMI-0"
    VendorName     "Unknown"
    ModelName      "DELL U2414H"
    HorizSync       30.0 - 83.0
    VertRefresh     56.0 - 76.0
    Option         "DPMS"
    Option      "RightOf" "DP-2"
EndSection

```

