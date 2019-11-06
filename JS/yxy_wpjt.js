/*
育学园-王牌讲堂
[Script]
http-response https:\/\/yxy.*\.drcuiyutao\.com.*lecture\/detail requires-body=1,max-size=0,script-path=王牌讲堂.js
[MITM]
hostname = drcuiyutao.com
*/

body = $response.body.replace(/\"type\":1/g, "\"type\":0");
$done({body});
