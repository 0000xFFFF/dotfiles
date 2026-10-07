cat /sys/class/dmi/id/product_name
vivobook_asus laptop x509ub


sudo pacman -S alsa-ucm-conf
reboot


sudo vim /etc/modprobe.d/alsa-base.conf

```
options snd-hda-intel model=alc256-asus-aio
```
# tested and works ^^^

OR TRY:

```
options snd-hda-intel model=alc256-asus-mic
```

OR TRY:

```
options snd-hda-intel model=laptop-dmic
```

reboot
