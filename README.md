# Dell-Inspiron-7590-Hackintosh-Opencore
OpenCore EFI for Dell Inspiron 759x.    
✅ 当前 macOS 版本 `11.0.1 RC`  `(20B28)` / 当前 EFI 包版本 `20.8.7 (Big Sur Test)`         
很惭愧，只对这款机器的黑苹果进程做了一点微小的工作！🐸
![](https://tva1.sinaimg.cn/large/0080xEK2ly1ghxf0391jbj31hc0u0qv5.jpg)
【**请注意 11.0 与 10.15 的 EFI 暂时不互通！**】等到 11.0 系统能够保证稳定且与 10.15 相近的体验时，本分支将合并入 `master`。

# 写在前面
> 希望无论是老鸟或新手都请认真阅读本部分，为自己的安装和使用减少不必要的麻烦！
> 对于 1080P 机型，核显可以直接采用 10.15 采用的 `DeviceProperties`。
* 默认支持 `DW1820A` 网卡（推荐使用：`BCM94356ZEPA50DX_2`，无需屏蔽针脚，可直接驱动）。
> Intel 网卡如需使用蓝牙，请参见 `IntelBT` 分支进行修改。Wifi 功能请参见仓库 [OpenIntelWireless](https://github.com/OpenIntelWireless/itlwm)。
* 默认屏蔽 1080P 机型 HDMI 音频输出，防止发生闪屏。如需手动打开请见后文。
* 经过测试，本 EFI 可以通过 10.15 直升和虚拟机安装两种方式成功进入系统。**对于直升建议在第一阶段的安装结束（完全离开 10.15 环境后 / 应该是一或两次重启后）再使用本 EFI**。<br>建议在升级前于 BIOS 屏蔽无线网卡及蓝牙，防止安装过程中玄学问题的发生（有概率，并不确定）。
* 建议在安装完成后，将 config.plist 中 `csr-active-config` 的值改为 `00000000`，打开系统 SIP 保护以正常使用 OTA 更新；否则可能检测不到更新。

# 目前存在的 Bug
11.0 版本目前 Bug 较多，不建议日常使用！
- [ ] ~启动间歇性出现卡 240s 问题，正在尝试修复。~
    > 应该已经修复，烦请各位测试！
- [ ] 由于使用 EDID 注入，4K 机型目前只能启用 48Hz 刷新率。
- [ ] HDMI 热插拔不太完美，可能无法自动识别设备接入或移除
    > 临时解决办法：接入 / 拔除 HDMI 线后，在 `系统偏好设置→显示器`界面下按住`Option`（即`Win`键），点击右下角「侦测显示器」重新侦测接入状况即可。
- [ ] 1080P 机型下 HDMI 如果设置输出声音，可能导致 HDMI 输出异常
    > 这样的异常可以通过使机器睡眠再唤醒而暂时解决。<br>对于 1080P 机型，输出声音与否通过 `DeviceProperties`->`PciRoot(0x0)/Pci(0x1f,0x3)` 中 `alc-device-id` 和 `alc-vendor-id` 的开闭来控制。如果不注入这两个参数则 HDMI 不会输出声音。<br>鉴于有一定数量朋友反馈输出声音会导致 HDMI 输出异常，自 `20.7.16` 版本起，这两个参数在 1080P 机型配置文件下默认被注释（即默认不输出声音）。如果愿意尝试，可以尝试去除条目前的 # 号开启这两个参数，当然并不保证能够成功，请自行测试。
- [ ] 雷电接口尚未测试，不确定功能可用性
- [ ] 内置麦克风无法使用【目前无解】
- [ ] DW1820A 蓝牙暂时无法从接收其他设备发来的文件。

# 声卡接口修复
在 `ComboJack` 文件夹中打开 `install.sh` 安装声卡接口守护进程，使得机器可以识别耳机接口的插拔。        
感谢 @[tctien342](https://github.com/tctien342) 的贡献！

# 4K 机型颜色配置文件
系统初次进入默认加载 sRGB 颜色配置，对于 4K 机型，这会导致观感不佳。
> 如有需要可以自行下载 4K 屏幕的校色文件：【[夏普 SHP14C7](http://oss.pm-z.tech/temp_files/SHP14C7_ICC.zip)】【[友达 AUO41EB](http://oss.pm-z.tech/temp_files/AUO41EB_ICC.zip)】<br>压缩包内已包含 Dell PremierColor 软件中的全部六种配置文件。<br>使用方法：解压压缩包后，将需要的 .icm 文件复制到：`~/Library/ColorSync/Profiles` 中，然后在 `系统偏好设置→显示器→颜色` 中选择相应的配置文件。<br>建议使用 `Adobe RGB` 或 `DCI-P3` 校色文件。这两款屏幕的色域覆盖为 100% Adobe RGB 和 90% DCI-P3。

# OpenCore GUI 界面资源包
config 默认已经启用了 GUI 界面，但由于资源包体积较大（约 100MB），故需要自行下载。  
如果不下载资源包则会自动显示为文字界面。  
资源包：[`acidanthera/OcBinaryData`](https://github.com/acidanthera/OcBinaryData)  
下载完后将 `Resources` 文件夹拷贝至 `OC` 文件夹（即与 `config.plist` 并列），之后就可以使用 GUI 界面了。  
界面即白苹果启动器原生界面：（图源网络）  
![](https://imacos.top/wp-content/uploads/2020/06/%E6%88%AA%E5%B1%8F2020-06-19-%E4%B8%8B%E5%8D%882.09.20.png)

# 升级到 11.0 DB4 需要注意
在 OTA 升级过程最后一次启动将进入系统时，可能会卡进度条。如出现该情况需要重置一次 NVRAM。

# 启动器中卷标显示为 `Preboot` 的解决办法
重新安装一遍 `Intel Power Gadget`。其安装过程会重写 `Preboot`，能够完成系统升级 / 安装时没有完成的这一步骤，使得卷标正常显示。
![](https://oss.pm-z.tech/img/Screen%20Shot%202020-08-07%20at%2011.58.38%20PM.png)

# 更新日志
## 2020/7/28
* 更新了 `Lilu`、`VirtualSMC` 到最新版本，适配 10.16 Beta 3

## 2020/8/7
* 更新  `OpenCore` 至 `2020-08-07` 版本，适配 10.16 Beta 4
* 更新 `AirportBrcmFixup` 至 `2.0.9`
* 默认启用 OpenCore 图形化界面（资源包需自行下载）

## 2020/11/18
* OC、Drivers、Kexts、ACPI 大幅更新
* （可能）修复了开机卡 240s 的问题

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
