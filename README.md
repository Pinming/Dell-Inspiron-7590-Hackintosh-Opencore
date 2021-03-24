# Dell-Inspiron-7590-Hackintosh-Opencore
OpenCore EFI for Dell Inspiron 759x.   _[English Version](https://github.com/Pinming/Dell-Inspiron-7590-Hackintosh-Opencore/blob/master/README.en.md)_       

✅ 当前 macOS 版本 `11.3 Beta 5` `(20E5217a)` / 当前 EFI 包版本 `21.3.18`  
✅ 支持 macOS `11.0`、`11.1`、`11.2` 全部版本以及 `11.3 Beta (>=4)`      
❌ 本分支*不再支持* `macOS 10.15`，如需安装 `10.15` 请参考 `Catalina_Backup` 分支         
❌ 请注意：*不要安装* `macOS 11.3 Beta 1 ~ 3` 版，上述版本无法正常进入系统      
⚠️ 本 EFI 在仅在 4K 夏普屏机型上经过测试，本文所有所述测试情况均基于本机型得出。      

【理论上】本 EFI 支持 Dell Inspiron 7590 / 7591 全系列机型。       
很惭愧，只对这款机器的黑苹果进程做了一点微小的工作！🐸
![](https://img03.sogoucdn.com/app/a/100540022/2021031801114349486906.jpg)


# 写在前面
> 希望无论是老鸟或新手都请认真阅读本部分，为自己的安装和使用减少不必要的麻烦！
* 本 EFI 在 @[tctien342](https://github.com/tctien342/Dell-Inspiron-7591-Hackintosh) 的 repo 基础上修改并优化，感谢！
* `config.plist` 供 4K 机型使用； `config-1080P.plist` 供 1080P 机型使用。<br>1080P 机型使用前请将对应 config 重命名为 `config.plist`；
* 经过测试，本 EFI 可以引导 Mac App Store 官方镜像进行全新安装；在新版本未出现兼容性问题的前提下，也支持 OTA 升级；
* 4K 及 1080P 机型都存在一定的个体差异，请仔细阅读「目前存在的 Bug」这一部分；
* 本人已经长期不使用 Intel 无线网卡，对其目前支持情况不甚了解。若需使用还请自行配置，敬请谅解；
* 版本号即为更新日期。如 2020/2/18 版本的版本号则为`20.2.18`。

# 声卡接口修复
在 `ComboJack` 文件夹中打开 `install.sh` 安装声卡接口守护进程，使得机器可以自动识别耳机接口的插拔。
感谢 @[hackintosh-stuff](https://github.com/hackintosh-stuff/ComboJack) 和 @[tctien342](https://github.com/tctien342) 的贡献！

# 4K 机型颜色配置文件
系统初次进入默认加载 sRGB 颜色配置，对于 4K 机型，这会导致观感不佳。
> 如有需要可以自行下载 4K 屏幕的校色文件：【[夏普 SHP14C7](http://oss.pm-z.tech/temp_files/SHP14C7_ICC.zip)】【[友达 AUO41EB](http://oss.pm-z.tech/temp_files/AUO41EB_ICC.zip)】<br>压缩包内已包含 Dell PremierColor 软件中的全部六种配置文件。<br>使用方法：解压压缩包后，将需要的 .icm 文件复制到：`~/Library/ColorSync/Profiles` 中，然后在 `系统偏好设置→显示器→颜色` 中选择相应的配置文件。<br>建议使用 `Adobe RGB` 或 `DCI-P3` 校色文件。这两款屏幕的色域覆盖为 100% Adobe RGB 和 90% DCI-P3。

# 目前存在的 Bug
- [x] ~启动间歇性出现卡 240s 问题~
- [x] ~由于使用 EDID 注入，4K 机型目前只能启用 48Hz 刷新率。~
    > 两款 4K 屏目前均不需要注入 EDID 即可以 60Hz 显示。
- [ ] HDMI 热插拔不太完美，可能无法自动识别设备接入或移除
    > 临时解决办法：接入 / 拔除 HDMI 线后，在 `系统偏好设置→显示器`界面下按住`Option`（即`Win`键），点击右下角「侦测显示器」重新侦测接入状况即可。
- [ ] 1080P 机型下 HDMI 如果设置输出声音，可能导致 HDMI 输出异常
    > 这样的异常可以通过使机器睡眠再唤醒而暂时解决。<br>对于 1080P 机型，输出声音与否通过 `DeviceProperties`->`PciRoot(0x0)/Pci(0x1f,0x3)` 中 `alc-device-id` 和 `alc-vendor-id` 的开闭来控制。如果不注入这两个参数则 HDMI 不会输出声音。<br>鉴于有一定数量朋友反馈输出声音会导致 HDMI 输出异常，自 `20.7.16` 版本起，这两个参数在 1080P 机型配置文件下默认被注释（即默认不输出声音）。如果愿意尝试，可以尝试去除条目前的 `#` 号开启这两个参数，当然并不保证能够成功，请自行测试。
- [ ] 雷电接口尚未测试，不确定功能可用性
- [ ] 内置麦克风无法使用【目前无解】
- [ ] DW1820A 蓝牙暂时无法从接收其他设备发来的文件。

# 更新日志
## 2020/2/16
* 对本 repo 进行通用化处理，使其可能兼容 7590 及 7591 的全系列机型
* 添加了来自于 `Dell PremierColor` 的校色文件，确保 4K 屏不会辣眼睛
## 2020/2/18
更换 `SMBIOS` 为 `MacBookPro15,3` 并优化了 SSDT 的内容，降低机器运行功耗（感谢 @tctien342）
## 2020/2/24
加入 `NullEthernet.kext`，便于在没有可用无线网卡的环境下实现原生白果功能
## 2020/3/2
* 升级 `OpenCore` 至 `0.5.6`，加入了 GUI 引导界面（鉴于 OpenCore 官方文档的建议及开发思路，待本 repo 全流程完成后将关闭 GUI，尽可能接近原生体验）
* 移除了英特尔蓝牙驱动，以避免可能出现的启动卡顿（反正也是要换网卡的）
## 2020/3/6
* HDMI 音视频都可以输出了！（感谢 @tctien342）
* 更新 `AppleHDA`，加入参数 `alc-delay=500` 使得 `AppleALC` 不会过早加载导致声卡掉驱动（感谢 @lvs1974）
* 更新 `VoodooI2C`，加入参数 `-btnforceclick`，将按压触控板视作为触发 `Force Click`（感谢 @tctien342）
## 2020/3/7
恢复添加并默认读取：`IntelBluetoothFirmware` & `IntelBluetoothInjector`，以便于在原装英特尔网卡的测试环境下使用蓝牙。如果没有需要可以自行屏蔽。
> 关于开机读取该驱动会导致卡顿的解决办法：在 Windows 的`设备管理器`中将蓝牙驱动回滚至初始版本即可。这一操作同时将蓝牙的固件恢复至初始状态，新固件在 macOS 下有 bug。（感谢 @DØP | Blyatman 的提示）
## 2020/3/8
* 更换 `VoodooTSCSync` 为 `CPUTSCSync`，修复睡眠死机问题（感谢 @lvs1974）
* 修复了 HDMI 热插拔识别
* 修改 UHD630 的显存为 3072MB（虽然不知道有什么卵用）
## 2020/3/9
修复了 1080P 机型 HDMI 外接显示器花屏（感谢 @Ariel 的测试）
## 2020/3/26
已无痛升级至 `10.15.4`，各项功能正常
## 2020/4/12
* 更新 `OpenCore` 至 `0.5.8 (20200410)` 版本
* 更新 `WhateverGreen` 至 `1.3.8` 版本，解决部分机型睡眠后黑屏问题（感谢 @kihsu 的提示）
## 2020/4/13
更新 `Lilu` 至 `1.4.3` 版本，与  `WhateverGreen` (`1.3.8`) 配套，防止无法进入系统（感谢 @XHL669、@ChasonJiang 的测试）
## 2020/4/17
已无痛升级至 `10.15.5 Beta 2 (19F62f)`，各项功能正常
## 2020/5/3
* 屏蔽 `SSDT-PLUG-_SB.PR00.aml`，确保 CPU 性能正常释放（PL1 = 45W / PL2 = 90W）
* ~~更新 `WhateverGreen` 至 `1.3.9` 版本，增加 `igfxfw=2` 参数以使用 Apple GuC Firmware (GuC = Graphics microController)，增强集显性能~~
    > 该更新会导致插入 HDMI 时 Kernel Panic，已回退该项更新。
## 2020/5/6
~~暂时回退 `WhateverGreen` 至 `1.3.8`，解决 HDMI 死机问题。~~
> 该问题已在 `20.5.28` 版本中得到解决。
## 2020/5/28
* 已无痛升级至 `10.15.5 GM (19F96)`，各项功能正常
* 更新 `WhateverGreen` 至 `1.4.0` 版本，增加 `igfxfw=2` 参数以使用 Apple GuC Firmware (GuC = Graphics microController)，增强集显性能
## 2020/5/30
增加对 DW1820A 的支持，停止对英特尔蓝牙的默认支持。
## 2020/6/3
* 已无痛升级至 `10.15.6 Beta 1(19G36e)`，各项功能正常
## 2020/7/16
* 默认关闭 1080P 机型 HDMI 的声音输出，如有需要请手动开启
* 增加 `DellSMCSensor`，可以通过 iStat Menus 或 MacFanControl 等软件控制风扇转速
## 2020/7/28
* 更新了 `Lilu`、`VirtualSMC` 到最新版本，适配 10.16 Beta 3
## 2020/8/7
* 更新 `OpenCore` 至 `2020-08-07` 版本，适配 10.16 Beta 4
* 更新 `AirportBrcmFixup` 至 `2.0.9`
* 默认启用 OpenCore 图形化界面（资源包需自行下载）
## 2020/11/18
* OC、Drivers、Kexts、ACPI 大幅更新
* 修复了开机卡 240s 的问题
## 2020/12/22
* 更新 `Lilu` 至 `1.5.0 (2020-12-16)`
* 更新 `WhateverGreen` 至 `1.4.6 (2020-12-16)`，应用 `-igfxmfc`，提升最大时钟频率，使得 4K 屏能在 60Hz 刷新率下工作
* 更新 `OpenCore` 至 `0.6.5 (2020-12-16)`
## 2021/3/18
* 放弃对 macOS 10.15 的支持
* 更新常用 Kexts
* 更新 `OpenCore` 至 `0.6.8 (2021-03-05)`

# 测试机硬件配置
## 已驱动 / 已知可驱动
**Dell Inspiron 7590** with Sharp SHP14C7 4K Display
* CPU：Intel Core i7-9750H @ 2.60 Ghz (Boost to 4.50 Ghz)
* IGPU：Intel Graphics UHD 630
* RAM：Hynix DDR4 2666Mhz / 16 GB * 2 = 32 GB RAM
* Display：Sharp SHP14C7 @ 15.6' / 4K
* SSD：WD PC SN730 NVMe WDC 512GB SSD
* Audio：Realtek ALC295（戴尔定制型号：ALC3254）（内置麦克风不能驱动）（Layout-ID = 77，选用 28 可能导致 kernel_task 占用过高而导致 CPU 高频不下）
* Micro SD Card Reader：Realtek Memory Card Reader（系统属性「读卡器」一栏无法识别，但可以正常使用）
* WLAN + Bluetooth：Broadcom DW1820A (`BCM94356ZEPA50DX_2`)

## 已知不可驱动
* Nvidia Geforce GTX 1650（无解）
* Intel Wireless-AC 9560（WiFi 有限度使用 / 仅蓝牙可使用）
* Goodix fingerpint reader（无解）
