#!/bin/sh
# 获取最新版本号
tag_name=`curl -s https://api.github.com/repos/zephyrchien/kaminari/releases/latest | grep tag_name|cut -f4 -d "\""`

# 最新版地址：
wget --no-check-certificate -qO- 'https://github.com/AdguardTeam/AdGuardHome/releases/download/$tag_name/kaminari-x86_64-unknown-linux-gnu.tar.gz'

# 解压到当前/root目录
tar -zxvf kaminari-x86_64-unknown-linux-gnu.tar.gz

#参考信息，支撑下面的输入
local-addr-sample==$(curl -s https://api.ip.sb/ip -A Mozilla)
echo -e $local-addr-sample

# 设置变量
read -p " 请输入本地监听【地址:端口】: " local-addr
read -p " 请输入目的【地址:端口】: " remote-addr
