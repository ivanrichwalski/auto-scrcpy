# Auto scrcpy

A set of files for automating launching [scrcpy](https://github.com/Genymobile/scrcpy) on Linux when I connect my phone with USB.

## How it works:

- Set your USB id and device serial number in Makefile
- Set PROGDIR to where you have extracted scrcpy
- If needed, set the other variables at the top of the Makefile
  to match your other system and user directories.

## Contents
- **99-auto-scrcpy-usb.rules**: Udev rules to match your android device, which launches auto-scrcpy.service
- **auto-scrcpy.service**: Systemd user unit file that's run on device connect
- **auto-scrcpy**: Launcher script to start scrcpy with your preferred options
- **scrcpy.desktop**: Application file so scrcpy can be available through your desktop's launcher.

## Installation
```
# make
# make install
```

## License
Licensed under the [MIT](LICENSE.md) license.
