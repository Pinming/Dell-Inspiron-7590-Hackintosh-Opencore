# Dell-Inspiron-7590-Hackintosh-Opencore
OpenCore EFI for Dell Inspiron 7590 with Sharp SHP14C7.      

**注意 | 本 EFI 仅供参考，系统目前各个可以驱动的主要硬件运行基本正常，但无线网卡尚未测试，相关完善将在近期进行。**

**建议先用 Clover 将系统正常安装再转换至 Opencore。本 EFI 暂未测试是否能进入安装界面。**

**【本 EFI 已集成 `WhateverGreen` 最新源码（`1.3.7`），夏普屏驱动问题已解决，理论上可以不使用二进制破解引导 10.15 各版本。感谢 @0xFirewolf！具体解决思路详见：https://github.com/acidanthera/WhateverGreen/pull/41 】**
![](http://tva1.sinaimg.cn/large/0080xEK2ly1gbstoz9de8j312s0pun9r.jpg)

# 目前存在的 Bug
* 无线网卡 / 雷电接口尚未测试，不确定功能可用性
* 内置麦克风无法使用【无解】
* 电池的容量 (Capacity) 识别错误，应为 97Wh，但实时电量显示基本准确
* 偶有出现声卡掉驱动现象，推测是 `AppleALC` 与 `AppleHDA` 间的加载顺序问题，一时可能无法解决
* HDMI 只能输出画面，不能输出声音
* 系统初次进入默认加载 sRGB 颜色配置，观感不佳。如有需要可以自行下载 Adobe RGB 的校色文件。【[夏普 SHP14C7](http://oss.pm-z.tech/temp_files/shp14c7_adobe_6500.icm)】【[友达 AUO41EB](http://oss.pm-z.tech/temp_files/AUO41EB_adobe_6500.icm)】

# 硬件配置

## 已驱动 / 已知可驱动
**Dell Inspiron 7590** with Sharp SHP14C7 4K Display
* CPU：Intel Core i7-9750H @ 2.60 Ghz (Boost to 4.50 Ghz)
* IGPU：Intel Graphics UHD 630
* RAM：Hynix DDR4 2666Mhz / 16 GB * 2 = 32 GB RAM
* Display：Sharp SHP14C7 @ 15.6' / 4K
* SSD：WD PC SN520 NVMe WDC 512GB SSD
* Audio：Realtek ALC295（戴尔定制型号：ALC3254）（内置麦克风不能驱动）（Layout-ID = 77，选用 28 可能导致 kernel_task 占用过高而导致 CPU 高频不下）
* 【计划 / 即将更换】_WLAN + Bluetooth：Broadcom DW1820A_

## 已知不可驱动
* Nvidia Geforce GTX 1650（无解）
* Realtek Memory Card Reader（无解）
* Intel Wireless-AC 9560（WiFi 无解 / 仅蓝牙可有限度使用）
* Goodix fingerpint reader（无解）
