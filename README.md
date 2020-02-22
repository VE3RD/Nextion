# Nextion Screen  2.4"
This screen was developed by Mitch EA7KDO and published on www.githud/ea7kdo/nextion.images
I have modified this screen, adding DMRGateway Control, Cross Modes and Profiles. this was done  to suit myself and no one else.

This is NOT a Production Package. It is my backup as I develope the screens. When I add new features, smetimes it breaks old ones. So use this at your own discretion.

The script [gitcopy.sh] will copy the source files for the Nextion Screen from github and place them in their appropriate directories ready to flash from the flash page on your hotspot(Assuming you have the EA7KDO File set installed in your screen.
On a new install, copy the NX3224K024.tft file to a clean microsd card, Power off your hotspot, insert the card into your screen and reboot. On completion, shut off the screen, remove the microsd card and reboot.

The batch file shwown below [copytft.bat] will transfer your screen tft file from it's original compiled directory to your pi-star at /home/pi-star
and then move it into /usr/local/etc by folowing instructions in the text.txt file located in /home/pi-star This occurs over wifi and no cable is required to connect the computer to the screen.

ie: after compiling, run copytft.bat and when done, run FLASH on the nextion screen (DO NOT RUN GIT COPY)

This batchfile requres PUTTY and PSCP which is installed with PUTTY.

Phil VE3RD


