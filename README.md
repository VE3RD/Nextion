# Nextion Screen  2.4"
This screen wa developed by Mitch EA7KDO and published on www.githud/ea7kdo/nextion.images
I have modified this screen with mainly cosmetic changes to suit myself and no one else.
This page is currently available only to myself and Mitch EA7KDO

This batch file will transfer your screen tft file from it original compiled directory to your pi-star at /home/pi-star
and then move it into /usr/local/etc by folowing instructions in the text.txt file located in /home/pi-star This occurs over wifi and no cable is required to connect the computer to the screen.

ie: after compiling, run copytft.bat and when done, run FLASH on the nextion screen (DO NOT RUN GIT COPY)

This batchfile requres PUTTY and PSCP which is installed with PUTTY.

Phil VE3RD

[copytft.bat]
putty.exe -ssh pi-star@0.0.0.0 -pw "raspberry" -m "C:\Users\WindowsUserName\AppData\Roaming\Nextion Editor\bianyi\setrw.txt"
cd "C:\Users\philt_000\AppData\Roaming\Nextion Editor\bianyi\"
del NX3224K024.tft
copy Nextion_2019_10_16_A_2-4_Test_Phil.tft NX3224K024.tft
timeout 2
pscp -l pi-star -pw raspberry "NX3224K024.tft" pi-star@192.168.4.102:/home/pi-star
timeout 5
putty.exe -ssh pi-star@192.168.4.102 -pw "raspberry" -m "test.txt"
