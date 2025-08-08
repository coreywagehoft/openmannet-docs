# OpenMANET Project

## Description
This project is very early. But, the goal is to build a Raspberry Pi based MANET radio using Wifi Halow. The project is based on using Morse Micro based pi hats.

I have a few optional components listed. I am currently testing an WaveShare 1850 UPS for power. I will include drivers for the USB Wifi adapter. The onboard one usually can't be used because it shares the same SDIO address as the halow boards.

## Roadmap
* Enclosue Design
* Step by Step instructions
* Investigate USB OTG/ Ethernet Gadget to allow EUD's to connect without ethernet to USB adapters.
* Test batman mesh

## In Progress
* A script that uses GPSD to do range testing, saving GPS locations and RSSI/SNR to a file for reporting.
* A PTT app to allow the radio to be functional without an EUD.
* Support for Seed and other SDIO based boards
* Raspberry Pi 3B+ and 2W support
* External 2.5/5ghz WiFi for bridging

## Steps
For some reason, the BCF is not getting copied to the image.

1. Flash the image to a sd card
2. Connect to the pi over 10.42.0.1, (you will need to set your laptop IP to something in this range like 10.42.0.100)
3. For some reason, the BCF is not getting copied over. So you will need to SCP it over.
    a. `scp  bcf_mf16858_fgh100mh_v6.3.0.bin root@10.42.0.1:/lib/firmware/morse`
4. SSH to the pi
    a. `ssh root@10.42.0.1`
    b. Run the following commands to load the BCF for this board.
```
uci set wireless.radio0.bcf=bcf_mf16858_fgh100mh_v6.3.0.bin
uci set wireless.radio0.enable_mcast_whitelist=0
uci set wireless.radio0.enable_mcast_whitelist=0
# Not sure if this actually affecting power output...
uci set wireless.radio0.tx_max_power_mbm=2600
uci commit
reload_config
reboot
```
5. Go to 10.42.0.1 in a browser
6. Follow the steps in the [manual](https://www.morsemicro.com/wp-content/uploads/2024/12/MM6108-EKH01-Eval-Kit-User-Guide-v18.pdf) to configure the device. I would suggest the `802.11s Mesh Wizard`.
7. The default build installs mediamtx (which may be useful for ATAK/UAS plugin video streams). But, it takes a ton of resources, so I disabled it for now.
```
/etc/init.d/mediamtx stop
/etc/init.d/mediamtx disable
```

## GPS Range Script
There is a range test script in the scripts folder. This uses the GPS module below to measure ping and RSSI/SNR. You will need to copy it to /root/, and do a `chmod +x rangetest.sh`. I have been using tmux to keep it running in the background.


## Parts List

| Item                                                                 | Link                                                                                                     | Optional |
|----------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------|----------|
| Wio WM6180 Wi-Fi HaLow mini PCIe Module                              | https://www.seeedstudio.com/Wio-WM6180-Wi-Fi-HaLow-mini-PCIe-Module-p-6394.html                         | No       |
| WM1302 Pi Hat                                                        | https://www.seeedstudio.com/WM1302-Pi-Hat-p-4897.html                                                   | No       |
| External Antenna 868/915MHz 2dBi SMA L195mm Foldable                 | https://www.seeedstudio.com/External-Antenna-868-915MHZ-2dBi-SMA-L195mm-Foldable-p-5863.html            | No       |
| UF.L to SMA-K 1.13 120mm Cable                                       | https://www.seeedstudio.com/UF-L-SMA-K-1-13-120mm-p-5046.html                                           | No       |
| Raspberry Pi 4 Computer Model B - 1GB                                | https://www.seeedstudio.com/Raspberry-Pi-4-Computer-Model-B-1GB-p-4078.html                             | No       |
| 18500 Battteries                                                     | https://www.amazon.com/dp/B0D3GX96H6?ref_=ppx_hzsearch_conn_dt_b_fed_asin_title_4                       | Yes      |
| WaveShare UPS B                                                      | https://www.amazon.com/gp/product/B0D39VDMDP/ref=ox_sc_saved_title_1?smid=A3B0XDFTVR980O&psc=1          | Yes      |
| Panda USB Wifi Adapter                                               | https://www.amazon.com/dp/B00762YNMG?ref_=ppx_hzsearch_conn_dt_b_fed_asin_title_1                       | Yes      |
| GPS USB Adapter                                                      | https://www.amazon.com/dp/B01MTU9KTF?ref_=ppx_hzsearch_conn_dt_b_fed_asin_title_1                       | Yes      |
