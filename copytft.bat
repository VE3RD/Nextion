putty.exe -ssh pi-star@192.168.4.102 -pw "raspberry" -m "C:\Users\philt_000\AppData\Roaming\Nextion Editor\bianyi\setrw.txt"
cd "C:\Users\philt_000\AppData\Roaming\Nextion Editor\bianyi\"
del NX3224K024.tft
copy Nextion_2019_10_16_A_2-4_Test_Phil.tft NX3224K024.tft
timeout 2
pscp -l pi-star -pw raspberry "NX3224K024.tft" pi-star@192.168.4.102:/home/pi-star
timeout 5
putty.exe -ssh pi-star@192.168.4.102 -pw "raspberry" -m "test.txt"
