/*
育学园-谈育儿
[Script]
http-response https:\/\/yxy.*\.drcuiyutao\.com.*getVipAudioDetailById requires-body=1,max-size=262144,script-path=yxy_tye.js
[MITM]
hostname = drcuiyutao.com
*/

body = $response.body.replace(/false/g, "true")
$done({body});
