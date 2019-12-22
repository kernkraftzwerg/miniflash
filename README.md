# miniflash
Perl script for flashing the Sonoff mini in DIY mode based on the tutorial by Andreas Spiess

## Background
The Sonoff mini comes with a DIY mode that supports flashing an own firmware (e.g. Tasmota). This mode is somewhat
difficult to handle manually and tools are only available for Windows, so I created this little helper script.

## Preconditions
You need:
* a Sonoff mini with an original firmware 3.1.x or higher,
* Perl and perl-libwww,
* an access point (e.g. wifi guest network) with SSID `sonoffDiy` and password `20170618sn`,
* a webserver in your local network with the new firmware,
* the tools `avahi-browse` and `curl` have to be installed.

## Procedure
1. The wifi network and the webserver have to be started.
2. Open the Sonoff mini, set the OTA jumper.
3. Connect power, wait some seconds util the mini connected to the network.
4. Execute the script with the firmware URL where you stored your new firmware on your local webserver.

## Note
The firmware has to be either tasmota-wifiman.bin, which starts a wifi access point for configuring your
wifi credentials or a self compiled binary with those credentials compiled in. I prefere the second method because
it saves a step of work and compiling Tasmota is rather easy thanks to platformio.
