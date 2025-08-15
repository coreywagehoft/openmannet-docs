# OpenMANET Project

## Description
This project is still in its early stages, but the goal is to build a Raspberry Pi based MANET (Mobile Ad-Hoc Network) radio using a Wi-Fi HaLow module from Seeed. It is designed around Morse Micro based Pi HATs and other compatible SDIO boards.

A number of optional components are listed in the parts list below. Currently, I am testing a WaveShare 1850 UPS for power. The build includes drivers for the Panda Wireless PAU06 USB Wi-Fi adapter. The onboard Wi-Fi on most Raspberry Pis cannot be used for client networking in this setup because it shares the same SDIO address as the HaLow boards. You can use either the USB WiFi or the ethernet adapter on the RPI4 to bridge connectivity.

## Roadmap
* Enclosure design  
* Step-by-step setup guide  
* Investigate USB OTG/Ethernet Gadget mode to allow EUDs to connect without USB-to-Ethernet adapters  
* Test B.A.T.M.A.N. mesh networking  

## In Progress
* GPS-based range-testing script using GPSD, logging GPS location, RSSI, and SNR for analysis  
* PTT (Push-to-Talk) application so the radio is functional without an EUD  
* Support for Seeed and other SDIO-based boards  
* Raspberry Pi 3B+ and 2W support  

## Advantages to using this over the Seeed image
* The BCF file is different, so the power goes from 21dbm to 27dbm
* The build is newer than the Seeed image
* The build includes 802.11s support

## Setup Steps

1. **Download the latest OpenMANET image**  
   Go to the [Releases section](https://github.com/OpenMANET/openwrt/releases) on the project GitHub page and download the image for your Raspberry Pi model.

2. **Flash the image to an SD card**  
   Use the [official Raspberry Pi guide](https://www.raspberrypi.com/documentation/computers/getting-started.html) for instructions on flashing the image.

3. **Initial connection**  
   When first powered on, the Pi boots with a static IP of **10.42.0.1**.  
   Connect your computer directly via Ethernet and set your computer to obtain an IP automatically. You must set a static IP address on your ethernet adapter(thats plugged into the pi) to `10.42.0.250` and you will be able to access the Pi at `10.42.0.1` in a web browser. If your computer is connected to WiFi, you can set the static IP on your ethernet adapter, and still stay connected to the internet at the same time.

4. **Switch to DHCP for normal operation**  
   After completing the initial configuration, it is recommended to set each node to use DHCP. This allows the Pi to automatically obtain an IP address from any connected network without manual configuration.  
   I have tested this successfully with my local home network and with a Starlink Mini providing DHCP.

5. **Initial configuration**  
   Follow the steps in the [Morse Micro EKH01 User Guide](https://www.morsemicro.com/wp-content/uploads/2024/12/MM6108-EKH01-Eval-Kit-User-Guide-v18.pdf).  
   It is recommended to complete **Section 3.1 “Initial Setup”** first, then **Section 3.9 “802.11s Mesh Configuration”** to establish your initial mesh link.

## Mediamtx disable
The default build installs mediamtx (which may be useful for ATAK/UAS plugin video streams). But, it takes a ton of resources, I will be removing this from the base build. But, to disable it now ssh into the pi, and run the following commands.
```
/etc/init.d/mediamtx stop
/etc/init.d/mediamtx disable
```

## GPS Range Testing Script
A range-test script is included in the `scripts` folder. It uses the GPS module listed in the parts list to measure ping, RSSI, and SNR. You can use SCP to transfer the file to the pi.

To use it:
```bash
cp scripts/rangetest.sh /root/
chmod +x /root/rangetest.sh
```
It is recommended to run it inside `tmux` so it continues running even if you disconnect.

## Parts List

| Item                                                                 | Link                                                                                                     | Optional |
|----------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------|----------|
| Wio WM6180 Wi-Fi HaLow mini PCIe Module                              | https://www.seeedstudio.com/Wio-WM6180-Wi-Fi-HaLow-mini-PCIe-Module-p-6394.html                         | No       |
| WM1302 Pi Hat                                                        | https://www.seeedstudio.com/WM1302-Pi-Hat-p-4897.html                                                   | No       |
| External Antenna 868/915 MHz 2 dBi SMA L195 mm Foldable              | https://www.seeedstudio.com/External-Antenna-868-915MHZ-2dBi-SMA-L195mm-Foldable-p-5863.html            | No       |
| UF.L to SMA-K 1.13 mm 120 mm Cable                                   | https://www.seeedstudio.com/UF-L-SMA-K-1-13-120mm-p-5046.html                                           | No       |
| Raspberry Pi 4 Computer Model B – 1 GB                               | https://www.seeedstudio.com/Raspberry-Pi-4-Computer-Model-B-1GB-p-4078.html                             | No       |
| 18500 Batteries                                                      | https://www.amazon.com/dp/B0D3GX96H6?ref_=ppx_hzsearch_conn_dt_b_fed_asin_title_4                       | Yes      |
| WaveShare UPS B                                                      | https://www.amazon.com/gp/product/B0D39VDMDP/ref=ox_sc_saved_title_1?smid=A3B0XDFTVR980O&psc=1          | Yes      |
| Panda USB Wi-Fi Adapter (PAU06)                                      | https://www.amazon.com/dp/B00762YNMG?ref_=ppx_hzsearch_conn_dt_b_fed_asin_title_1                       | Yes      |
| GPS USB Adapter                                                      | https://www.amazon.com/dp/B01MTU9KTF?ref_=ppx_hzsearch_conn_dt_b_fed_asin_title_1                       | Yes      |


## Project Photos

![Setup photo 1](pics/IMG_8358.jpg)
![Setup photo 2](pics/IMG_8359.jpg)
![Setup photo 3](pics/IMG_8360.jpg)
![Setup photo 4](pics/IMG_8362.jpg)