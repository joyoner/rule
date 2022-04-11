#!/bin/sh
# 获取最新版本号
tag_name=$(curl -s https://api.github.com/repos/zephyrchien/kaminari/releases/latest | grep tag_name|cut -f4 -d "\"")
# 最新版地址
#wget --no-check-certificate -N https://github.com/zephyrchien/kaminari/releases/download/"$tag_name"/kaminari-x86_64-unknown-linux-gnu.tar.gz
wget --no-check-certificate -N https://ghproxy.com/https://github.com/zephyrchien/kaminari/releases/download/"$tag_name"/kaminari-x86_64-unknown-linux-gnu.tar.gz

# 解压到当前目录
tar -zxvf kaminari-x86_64-unknown-linux-gnu.tar.gz && rm -f kaminari-x86_64-unknown-linux-gnu.tar.gz

#local_addr_sample=$(curl -s https://api.ip.sb/ip -A Mozilla)
#echo "本地地址：$local_addr_sample"

start(){
    if [[ $forward_type == "1" ]];then
        read -p " 请输入域名: " server_name
        ./kaminaris 0.0.0.0:$local_port $remote_addr:$remote_port 'tls;servername='$server_name''
    elif [[ $forward_type == "2" ]];then
        ./kaminaric  0.0.0.0:$local_port $remote_addr:$remote_port 'tls;sni=$sni;insecure;0rtt'
    else
        echo -e "参数输入有误！"
    fi
}

# 设置变量
echo "最新版本：$tag_name"
read -p " 请输入转发模式【1:server；2:client】: " forward_type 
read -p " 请输入本地监听端口: " local_port
read -p " 请输入目的地址: " remote_addr
read -p " 请输入目的端口: " remote_port
start
