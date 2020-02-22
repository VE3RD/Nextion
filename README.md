# Nextion Screen  2.4"
This screen was developed by Mitch EA7KDO and published on www.githud/ea7kdo/nextion.images
I have modified this screen with mainly cosmetic changes to suit myself and no one else.

This is NOT a production Packge. It is my backup as I develope. When I add new features, smetimes it breaks old ones. So use this at your own discretion.

The script [gitcopy.sh] will copy the source files for the Nextion Screen from github and place them in their appropriate directories ready to flash from the flash page on your hotspot(Assuming you have the EA7KDO File set installed in your screen.
On a new install, copy the NX3224K024.tft file to a clean microsd card, Powsedr off your hotspot, insert the card into your screen and reboot. On completion, shut off the screen, remove the microsd card and reboot.

This batch file [copytft.bat] will transfer your screen tft file from it's original compiled directory to your pi-star at /home/pi-star
and then move it into /usr/local/etc by folowing instructions in the text.txt file located in /home/pi-star This occurs over wifi and no cable is required to connect the computer to the screen.

ie: after compiling, run copytft.bat and when done, run FLASH on the nextion screen (DO NOT RUN GIT COPY)

This batchfile requres PUTTY and PSCP which is installed with PUTTY.

Phil VE3RD

[setrw] - Sets Pi-Star to RW and removes previous NX3224K024.tft - Used by copytft.bat
sudo mount -o remount,rw /
sudo rm NX3224K024.tft

[copytft.bat] 
{1 run putty to run setrw above}
putty.exe -ssh pi-star@0.0.0.0 -pw "raspberry" -m "C:\Users\WindowsUserName\AppData\Roaming\Nextion Editor\bianyi\setrw.txt"
{Change to Compiler Output Directory}
cd "C:\Users\philt_000\AppData\Roaming\Nextion Editor\bianyi\"
{Delete Old NX3224K024}
del NX3224K024.tft
{Copy new Compiled File to NX3224K024.tft}
copy CompiledScreenileName.tft NX3224K024.tf   // Modify - Use your own compiled .tft file name
{2 second delay}
timeout 2
{Copy NX3224K024.tft to pi-star  /local/pi-star }
pscp -l pi-star -pw raspberry "NX3224K024.tft" pi-star@0.0.0.0:/home/pi-star     //Modify- Your IP Address
{5 second Delay}
timeout 5
{Run the command in pi-star /home/pi-star/test.txt }
putty.exe -ssh pi-star@0.0.0.0 -pw "raspberry" -m "test.txt"                 //Modify- Your IP Address

[test.txt]
#!/bin/bash
sudo mount -o remount,rw /                   //Make Drive RW
sudo cp /home/pi-star/NX3224K024.tft /usr/local/etc/   //copy new NX3224K024.tft  to /usr/local/etc where the Nextion Screen can find it.

