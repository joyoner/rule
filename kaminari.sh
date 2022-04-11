#!/bin/sh
# 获取最新版本号
tag_name=$(curl -s https://api.github.com/repos/zephyrchien/kaminari/releases/latest | grep tag_name|cut -f4 -d "\"")
# 获取最新版地址
cd /root/
#wget --no-check-certificate -N https://github.com/zephyrchien/kaminari/releases/download/"$tag_name"/kaminari-x86_64-unknown-linux-musl.tar.gz
wget --no-check-certificate -N https://ghproxy.com/https://github.com/zephyrchien/kaminari/releases/download/"$tag_name"/kaminari-x86_64-unknown-linux-musl.tar.gz

# 解压到当前目录
tar -zxvf kaminari-x86_64-unknown-linux-musl.tar.gz && rm -f kaminari-x86_64-unknown-linux-musl.tar.gz

#local_addr_sample=$(curl -s https://api.ip.sb/ip -A Mozilla)
#echo "本地地址：$local_addr_sample"

start_ws(){
    if [[ $forward_type == "1" ]];then
        read -p " 请输入HOST【example.com】: " host
        read -p " 请输入PATH【/ws】: " path
        nohup /root/kaminaris 0.0.0.0:$local_port $remote_addr:$remote_port 'ws;host='$host';path='$path'' >> /dev/null 2>&1 &
    elif [[ $forward_type == "2" ]];then
        read -p " 请输入HOST【example.com】: " host
        read -p " 请输入PATH【/ws】: " path
        nohup /root/kaminaric 0.0.0.0:$local_port $remote_addr:$remote_port 'ws;host='$host';path='$path'' >> /dev/null 2>&1 &
    else
        echo -e "参数输入有误！作为server请输入1，作为client请输入2，退出..."
    fi
}

start_tls(){
    if [[ $forward_type == "1" ]];then
        read -p " 请输入域名: " server_name
        nohup /root/kaminaris 0.0.0.0:$local_port $remote_addr:$remote_port 'tls;servername='$server_name'' >> /dev/null 2>&1 &
    elif [[ $forward_type == "2" ]];then
        read -p " 请输入域名SNI: " sni_name
        nohup /root/kaminaric  0.0.0.0:$local_port $remote_addr:$remote_port 'tls;sni='$sni_name';insecure;0rtt' >> /dev/null 2>&1 &
    else
        echo -e "参数输入有误！作为server请输入1，作为client请输入2，退出..."
    fi
}

start_wss(){
    if [[ $forward_type == "1" ]];then
        read -p " 请输入HOST【example.com】: " host
        read -p " 请输入PATH【/ws】: " path
        read -p " 请输入域名: " server_name
        nohup /root/kaminaris 0.0.0.0:$local_port $remote_addr:$remote_port 'ws;tls;host='$host';path='$path';servername='$server_name'' >> /dev/null 2>&1 &
    elif [[ $forward_type == "2" ]];then
        read -p " 请输入HOST【example.com】: " host
        read -p " 请输入PATH【/ws】: " path
        read -p " 请输入域名SNI: " sni_name
        nohup /root/kaminaric 0.0.0.0:$local_port $remote_addr:$remote_port 'ws;tls;host='$host';path='$path';sni='$sni_name';insecure;0rtt' >> /dev/null 2>&1 &
    else
        echo -e "参数输入有误！作为server请输入1，作为client请输入2，退出..."
    fi
}

# 设置变量
echo "最新版本：$tag_name"
read -p " 请输入转发模式【1:server | 2:client】: " forward_type
read -p " 请输入传输协议【ws/tls/wss】: " protocol 
read -p " 请输入本地监听端口: " local_port
read -p " 请输入转发目的地址: " remote_addr
read -p " 请输入转发目的端口: " remote_port

start(){
    if [[ $protocol == "ws" ]];then
        start_ws
    elif [[ $protocol == "tls" ]];then
        start_tls
    elif [[ $protocol == "wss" ]];then
        start_wss
    else
        echo -e "传输协议输入有误，仅支持ws/tls/wss！"
    fi
}

start
