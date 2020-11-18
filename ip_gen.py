import ipaddress
fw=open("./anycast.txt",'w')
net=ipaddress.ip_network('104.19.0.0/16')
net
for a in net:
  print(a,file=fw)

fw.close()
