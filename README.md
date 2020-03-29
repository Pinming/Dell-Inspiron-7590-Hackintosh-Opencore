# Dell-Inspiron-7590-Hackintosh-Opencore
OpenCore EFI for Dell Inspiron 759x.   _[English Version](https://github.com/Pinming/Dell-Inspiron-7590-Hackintosh-Opencore/blob/master/README.en.md)_ 
✅ 当前 macOS 版本 `10.15.4` / 当前 EFI 包版本 `20.3.9`
【理论上】本 EFI 支持 Dell Inspiron 7590 / 7591 全系列机型。       
很惭愧，只对这款机器的黑苹果进程做了一点微小的工作！🐸
![](https://tva1.sinaimg.cn/large/0080xEK2ly1gday15hkgaj31hc0u04qp.jpg)

# 写在前面
* 本 EFI 仅供参考，系统目前各个可以驱动的主要硬件运行基本正常，但 Broadcom 无线网卡尚未测试，相关完善将在近期进行。
* 本 EFI 在 @[tctien342](https://github.com/tctien342/Dell-Inspiron-7591-Hackintosh) 的 repo 基础上修改并优化，感谢！
* EFI 已集成 `WhateverGreen` 最新源码（`1.3.7`），夏普屏驱动问题已解决，理论上可以不使用二进制破解引导 10.15 各版本。感谢 @[0xFirewolf](https://github.com/0xfirewolf)！具体解决思路详见：https://github.com/acidanthera/WhateverGreen/pull/41
* `config.plist` 与 `config-1080P.plist` 的异同：前者相较于后者移除了两个值：`device-id` & `AAPL,ig-platform-id`，以保证 4K 机型在 Opencore 环境下不会出现奇怪的花屏或无法进入系统等问题。即 4K 屏幕采用  `config.plist`，1080P 屏幕采用 `config-1080P.plist` 即可。
* 本 `config` 对于无线网卡及蓝牙的默认操作：<br>默认加载 `IntelBluetoothFirmware`；默认将 Broadcom 无线网卡的各项驱动安置在 `\OC\kexts` 文件夹中但**不启用**。<br>如果已经更换了 Broadcom 无线网卡，请自行将 `Kernel -> Add` 中网卡相关 kexts 的 `Enabled` 项启用，并删除 `boot-args` 中相应启动参数的 `#` 号。此外，还需在 kext 设置中屏蔽 `NullEthernet.kext` 并在 SSDT 设置中屏蔽 `SSDT-RMNE`。
* 版本号即为更新日期。如 2020/2/18 版本的版本号则为`20.2.18`。

# 声卡接口修复
在 `ComboJack` 文件夹中打开 `install.sh` 安装声卡接口守护进程，使得机器可以识别耳机接口的插拔。        
在最新版的 `ComboJack` 中（2020/2/18 之后），插入耳机将自动识别，不再出现弹窗。
感谢 @[tctien342](https://github.com/tctien342) 的贡献！
![](http://tva1.sinaimg.cn/large/0080xEK2ly1gbzgvhggtbj30tk0ewahj.jpg)

# 4K 机型颜色配置文件
系统初次进入默认加载 sRGB 颜色配置，对于 4K 机型，这会导致观感不佳。
> 如有需要可以自行下载 4K 屏幕的校色文件：【[夏普 SHP14C7](http://oss.pm-z.tech/temp_files/SHP14C7_ICC.zip)】【[友达 AUO41EB](http://oss.pm-z.tech/temp_files/AUO41EB_ICC.zip)】<br>压缩包内已包含 Dell PremierColor 软件中的全部六种配置文件。<br>使用方法：解压压缩包后，将需要的 .icm 文件复制到：`~/Library/ColorSync/Profiles` 中，然后在 `系统偏好设置→显示器→颜色` 中选择相应的配置文件。<br>建议使用 `Adobe RGB` 或 `DCI-P3` 校色文件。这两款屏幕的色域覆盖为 100% Adobe RGB 和 90% DCI-P3。

# 目前存在的 Bug
- [x] ~~4K 机型下 HDMI 只能输出画面，不能输出声音~~
- [x] ~~偶有出现声卡掉驱动现象，推测是 `AppleALC` 与 `AppleHDAController` 间的加载顺序问题，一时可能无法解决~~
- [x] ~~短时间的合盖睡眠可能导致系统崩溃~~
- [x] ~~在 HDMI 热插拔后，电脑不能正常退出投影模式（即没有识别出 HDMI 已拔出）~~
    > ~~临时解决办法：拔除 HDMI 线后，在 `系统偏好设置→显示器`界面下按住`Option`（即`Win`键），点击右下角「侦测显示器」重新侦测接入状况即可。~~
- [ ] 1080P 机型下 HDMI 只能输出画面，不能输出声音
- [ ] 无线网卡 / 雷电接口尚未测试，不确定功能可用性
- [ ] 内置麦克风无法使用【目前无解】
- [ ] 电池的容量 (Capacity) 识别错误，应为 97Wh，但实时电量显示基本准确

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
> 关于开机读取该驱动会导致卡顿的解决办法：在 Windows 的`设备管理器`中将蓝牙驱动回滚至初始版本即可。这一操作同时将蓝牙的固件恢复至初始状态，新固件在 macOS 下有 bug。（感谢 @DØP | Blyatmand 的提醒）
## 2020/3/8
* 更换 `VoodooTSCSync` 为 `CPUTSCSync`，修复睡眠死机问题（感谢 @lvs1974）
* 修复了 HDMI 热插拔识别
* 修改 UHD630 的显存为 3072MB（虽然不知道有什么卵用）
## 2020/3/9
修复了 1080P 机型 HDMI 外接显示器花屏（感谢 @Ariel 的测试）
## 2020/3/26
已无痛升级至 `10.15.4`，各项功能正常

# 测试机硬件配置
## 已驱动 / 已知可驱动
**Dell Inspiron 7590** with Sharp SHP14C7 4K Display
* CPU：Intel Core i7-9750H @ 2.60 Ghz (Boost to 4.50 Ghz)
* IGPU：Intel Graphics UHD 630
* RAM：Hynix DDR4 2666Mhz / 16 GB * 2 = 32 GB RAM
* Display：Sharp SHP14C7 @ 15.6' / 4K
* SSD：WD PC SN520 NVMe WDC 512GB SSD
* Audio：Realtek ALC295（戴尔定制型号：ALC3254）（内置麦克风不能驱动）（Layout-ID = 77，选用 28 可能导致 kernel_task 占用过高而导致 CPU 高频不下）
* Micro SD Card Reader：Realtek Memory Card Reader（系统属性「读卡器」一栏无法识别，但可以正常使用）
* 【计划 / 即将更换】_WLAN + Bluetooth：Broadcom DW1560_

## 已知不可驱动
* Nvidia Geforce GTX 1650（无解）
* Intel Wireless-AC 9560（WiFi 无解 / 仅蓝牙可使用）
* Goodix fingerpint reader（无解）
