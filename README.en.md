# Dell-Inspiron-7590-Hackintosh-Opencore
OpenCore EFI for Dell Inspiron 759x.

In theory, this EFI supports for all models of Dell Inspiron 7590 / 7591 Series.
![](http://tva1.sinaimg.cn/large/0080xEK2ly1gbzh20adfrj312s0puk0z.jpg)

# Introduction
* The EFI for reference only in present. All hardware can normally work but wireless card have not been tested yet.
* The EFI is based on @[tctien342](https://github.com/tctien342/Dell-Inspiron-7591-Hackintosh)'s repo. Thanks!
* The EFI has included the latest source code of `WhateverGreen` (`1.3.7`) ,it solved the problem on the Sharp SHP14C7 4K screen. Now it can boot any version of macOS 10.15 without binary patches.
* Differences between `config.plist` & `config-1080P.plist`: Comparing to `config-1080P.plist`, the former has been removed two strings - `device-id` & `AAPL,ig-platform-id` to ensure that 4K screen will be normally driven and avoid some problems such as graphics glitch or stuck on booting. Therefore, `config.plist` is fit for 4K model and `config-1080P.plist` is fits for 1080P model.

# Fix the Combojack Support
Execute `install.sh` in folder `ComboJack` to install an combojack protecting process, so that your computer can make response when you plug in an audio device.
Thanks to @[hackintosh-stuff](https://github.com/hackintosh-stuff/ComboJack) and @[tctien342](https://github.com/tctien342).

# Known Problems
* Wireless Card & ThunderBolt have not been tested yet and can't confirm whether they are available.
* Internal Microphone doesn't work.
* It can't read proper battery capacity (Should be 97 Wh instead of 85Wh). But the percentage of remaining battery is correct.
* Audio sometime not working if mac installed in fast NVME drive, due to the loading order of `AppleALC` & `AppleHDA`.
* HDMI can't output audio.
* It will load the default sRGB color profile. For 4K model, it is an incorrect profile but you can apply Adobe RGB color profile for your screen to improve the color experience.
> Download: ([Sharp SHP14C7](http://oss.pm-z.tech/temp_files/SHP14C7_ICC.zip)) ([AUO AUO41EB](http://oss.pm-z.tech/temp_files/AUO41EB_ICC.zip))<br>Each package includes all 6 profiles which are extracted from Dell PremierColor. <br>Copy .icm files to `~/Library/ColorSync/Profiles` and apply the color profile you need in `System Preferences→Displays→Color`.

# Tested Hardware

## Can be driven
**Dell Inspiron 7590** with Sharp SHP14C7 4K Display
* CPU: Intel Core i7-9750H @ 2.60 Ghz (Boost to 4.50 Ghz)
* IGPU: Intel Graphics UHD 630
* RAM: Hynix DDR4 2666Mhz / 16 GB * 2 = 32 GB RAM
* Display: Sharp SHP14C7 @ 15.6' / 4K
* SSD: WD PC SN520 NVMe WDC 512GB SSD
* Audio: Realtek ALC295 (ALC3254) (Internal Mic couldn't be driven) (Layout-ID = 77, if you choose 28 may lead to high CPU utilization by kernel_task）
* Micro SD Card Reader: Goodix fingerpint reader (Couldn't be recognized on system report, but could work properly)
* 【Plan to test】_WLAN + Bluetooth: Broadcom DW1820A_

## Can not be driven
* Nvidia Geforce GTX 1650
* Realtek Memory Card Reader
* Intel Wireless-AC 9560

