/*
育学园-王牌讲堂
[Script]
http-response https:\/\/yxy.*\.drcuiyutao\.com.*lecture\/detail requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/joyoner/rule/master/JS/yxy_wpjt.js
[MITM]
hostname = yxyapi*.drcuiyutao.com
*/

body = $response.body.replace(/\"type\":1/g, "\"type\":0");
$done({body});
