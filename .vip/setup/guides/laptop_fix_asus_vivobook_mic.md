# Get Laptop Info:

```
cat /sys/class/dmi/id/product_name
```

```
vivobook_asus laptop x509ub
```

# Troubleshooting: Internal Microphone on ASUS VivoBook X509 (Arch Linux)

This is a known issue with the **ASUS VivoBook X509** series on Linux (specifically those using the **ALC256** codec). It often occurs because the kernel fails to correctly map the internal microphone pins or requires specific firmware that isn't loaded by default.

Follow these steps in order to fix the detection.

### 1. Install Necessary Firmware

The internal microphone on newer ASUS laptops often requires the **SOF (Sound Open Firmware)** package to function.

- Open your terminal and run:
  ```bash
  sudo pacman -S sof-firmware alsa-ucm-conf
  ```
- **Reboot** your laptop after installing.

---

### 2. Apply the Modprobe Fix

If the mic is still not detected, you likely need to "force" a specific model configuration for the `snd-hda-intel` driver.

1.  Create or edit the audio configuration file:
    ```bash
    sudo nano /etc/modprobe.d/alsa-base.conf
    ```
2.  Add the following line to the end of the file:
    ```text
    options snd-hda-intel model=alc256-asus-mic
    ```
    _(Note: If that doesn't work, you can later try replacing it with `model=alc256-asus-aio` or `model=laptop-dmic`)_.
3.  Save (**Ctrl+O**, then **Enter**) and exit (**Ctrl+X**).
4.  **Reboot** your system.

---

### 3. Check for "Muted" Status in Alsamixer

Sometimes the device is detected but the "Capture" channel is muted at the hardware level.

1.  Run `alsamixer` in your terminal.
2.  Press **F6** and select your sound card (usually **HDA Intel PCH**).
3.  Press **F5** to view all channels.
4.  Look for columns labeled **Internal Mic** or **Capture**.
5.  If you see **[MM]** at the bottom, it is muted. Press the **M** key to unmute it (it should change to **[OO]**).
6.  Use the arrow keys to increase the gain/volume.

---

### 4. Verify with Pavucontrol

Arch Linux users often use PipeWire or PulseAudio. The default settings app may not show all "Ports."

1.  Install the volume control GUI: `sudo pacman -S pavucontrol`
2.  Open **PulseAudio Volume Control**.
3.  Go to the **Input Devices** tab.
4.  Ensure "Show" is set to **All Input Devices**.
5.  Check the **Port** dropdown. If you see "Internal Microphone (unplugged)," try selecting it anyway; sometimes the "unplugged" status is a reporting error.

---

### 5. The "Cold Boot" Trick (Important for Dual Boot)

If you recently rebooted from Windows into Arch, the Windows driver sometimes leaves the audio chip in a state that Linux can't initialize.

- **Shut down** the laptop completely.
- Wait 10 seconds.
- **Power on** directly into Arch Linux.
