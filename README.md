# Dell-Inspiron-7590-Hackintosh-Opencore
OpenCore EFI for Dell Inspiron 759x.    
✅ 当前 macOS 版本 `10.16 Beta1`  `(20A4299v)` / 当前 EFI 包版本 `20.7.11 (Big Sur Test)`       
很惭愧，只对这款机器的黑苹果进程做了一点微小的工作！🐸
![](https://tva1.sinaimg.cn/large/0080xEK2ly1ggn8dthtolj31hc0u0u0y.jpg)

# 写在前面
> 希望无论是老鸟或新手都请认真阅读本部分，为自己的安装和使用减少不必要的麻烦！
* 本 EFI 目前只能确保兼容 `夏普 4K + DW1820A` 的搭配，其他 `4K` 机型欢迎套用并测试反馈！
> 对于 1080P 机型，可以删去 config.plist 中的 EDID 条目。该条目主要用于临时防止 4K 屏幕时钟频率校验失败，1080P 机型应该不存在这一问题。
* 默认支持 `DW1820A` 网卡（推荐使用：`BCM94356ZEPA50DX_2`，无需屏蔽针脚，可直接驱动）。
> Intel 网卡如需使用蓝牙，请参见 `IntelBT` 分支进行修改。Wifi 功能请参见仓库 [OpenIntelWireless](https://github.com/OpenIntelWireless/itlwm)。
* 经过测试，本 EFI 可以通过 10.15 直升和虚拟机安装两种方式成功进入系统。建议在第一阶段的安装结束（完全离开 10.15 环境后）再使用本 EFI。<br>建议在升级前于 BIOS 屏蔽无线网卡及蓝牙，防止安装过程中玄学问题的发生（有概率，并不确定）。

# 目前存在的 Bug
- [ ] 【新增】4K 机型目前只能启用 48Hz 刷新率。
- [ ] HDMI 热插拔不太完美，可能无法自动识别设备接入或移除
    > 临时解决办法：接入 / 拔除 HDMI 线后，在 `系统偏好设置→显示器`界面下按住`Option`（即`Win`键），点击右下角「侦测显示器」重新侦测接入状况即可。
- [ ] 1080P 机型下 HDMI 可能只输出画面，不输出声音
    > 如果愿意尝试，也可以套用 4K 版的 config 使其输出声音，当然并不保证能够成功。~~「搏一搏，单车变摩托」~~
- [ ] 雷电接口尚未测试，不确定功能可用性
- [ ] 内置麦克风无法使用【目前无解】
- [ ] 电池的容量 (Capacity) 识别错误，应为 97Wh，但实时电量显示基本准确
- [ ] DW1820A 蓝牙暂时无法从接收其他设备的文件。

# 声卡接口修复
在 `ComboJack` 文件夹中打开 `install.sh` 安装声卡接口守护进程，使得机器可以识别耳机接口的插拔。        
感谢 @[tctien342](https://github.com/tctien342) 的贡献！
![](http://tva1.sinaimg.cn/large/0080xEK2ly1gbzgvhggtbj30tk0ewahj.jpg)

# 4K 机型颜色配置文件
系统初次进入默认加载 sRGB 颜色配置，对于 4K 机型，这会导致观感不佳。
> 如有需要可以自行下载 4K 屏幕的校色文件：【[夏普 SHP14C7](http://oss.pm-z.tech/temp_files/SHP14C7_ICC.zip)】【[友达 AUO41EB](http://oss.pm-z.tech/temp_files/AUO41EB_ICC.zip)】<br>压缩包内已包含 Dell PremierColor 软件中的全部六种配置文件。<br>使用方法：解压压缩包后，将需要的 .icm 文件复制到：`~/Library/ColorSync/Profiles` 中，然后在 `系统偏好设置→显示器→颜色` 中选择相应的配置文件。<br>建议使用 `Adobe RGB` 或 `DCI-P3` 校色文件。这两款屏幕的色域覆盖为 100% Adobe RGB 和 90% DCI-P3。


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
