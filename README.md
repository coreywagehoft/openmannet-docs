# OpenMANET Project

## Description
This project is very early. But, the goal is to build a Raspberry Pi based MANET radio using Wifi Halow. The project is based on using Morse Micro based pi hats.

I have a few optional components listed. I am currently testing an WaveShare 1850 UPS for power. I will include drivers for the USB Wifi adapter. The onboard one usually can't be used because it shares the same SDIO address as the halow boards.

## Roadmap
* Enclosue Design
* Step by Step instructions
* Investigate USB OTG/ Ethernet Gadget to allow EUD's to connect without ethernet to USB adapters.

## In Progress
* A script that uses GPSD to do range testing, saving GPS locations and RSSI/SNR to a file for reporting.
* A PTT app to allow the radio to be functional without an EUD.
* Support for Seed and other SDIO based boards
* Raspberry Pi 3B+ and 2W support
* External 2.5/5ghz WiFi for bridging

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
