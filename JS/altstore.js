/*
[Script]
http-response ^https://cdn.altstore.io/file/altstore/apps.json requires-body=1,max-size=0,debug=1,script-path=https://raw.githubusercontent.com/joyoner/rule/master/JS/altstore.js
[MITM]
hostname = cdn.altstore.io
*/

const body = $response.body
const obj = JSON.parse(body);
obj.apps = obj.apps.map(i => {
  i.versionDate = "2019-09-25"
  if (i.beta) {
    delete i.beta
    i.name = i.name + ' - Beta'
  }
  return i
})
$done({body: JSON.stringify(obj)});
