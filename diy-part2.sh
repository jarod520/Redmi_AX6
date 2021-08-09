#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.50.1/g' package/base-files/files/bin/config_generate
# 修改版本信息
date=`date +%Y.%m.%d`
sed -i 's/OpenWrt/OpenWrt Build '$date' By Jarod Chang/g' package/lean/default-settings/files/zzz-default-settings
sed -i 's/%D %V, %C/%D %V, '$date' By Jarod Chang/g' package/base-files/files/etc/banner
# 修改连接数数
#sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
#修正连接数（by ベ七秒鱼ベ）
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65535' package/base-files/files/etc/sysctl.conf
#设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings
# 修改插件名字
sed -i 's/"带宽监控"/"带宽"/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
#移除不用软件包  
rm -rf package/lean/luci-app-ttyd
rm -rf feeds/packages/utils/ttyd
rm -rf package/lean/luci-theme-argon
#添加额外非必须软件包
#git clone https://github.com/garypang13/luci-app-bypass package/luci-app-bypass
git clone https://github.com/vernesong/OpenClash.git package/OpenClash
svn co https://github.com/jarod360/packages/trunk/ttyd package/ttyd
git clone https://github.com/jarod360/luci-app-ttyd package/luci-app-ttyd
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
git clone https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
#git clone -b luci https://github.com/pexcn/openwrt-chinadns-ng.git package/luci-app-chinadns-ng
# Add luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
