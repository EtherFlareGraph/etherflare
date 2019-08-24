DDOS Token
===
`address`: `0x7ba6f306be7107340f12d8e3a38fb41e5cb97575`


Oracle
===
Oracle contract address: `0xc7012b76c58d1e9494e58989a8c092e742ae69f8`
Link: `0x20fe562d797a42dcb3399062ae9546cd06f63280`
Deployed from: `0xB5dc4847bCE62f2873ce681ffc13fC3D5E6E8d74`
Chain: `ropsten`
Node address: `0xE84a93d372CbAe15BE56a07C602F7a1bE6FB6Ea3`

Pingdom
===
application id: `2dorjf2ktnhor0g71e6cdocjzeidznyz`
pingdom api base url: `https://api.pingdom.com`
login: `kk@4irelabs.com`
pass: `inside90`


1. Get check_id:
---
JOBID: `0x4ecbccba40b64fefbb24a8544efe87b8`
```
curl -X GET \
  https://api.pingdom.com/api/2.1/checks \
  -H 'Accept: */*' \
  -H 'App-Key: 2dorjf2ktnhor0g71e6cdocjzeidznyz' \
  -H 'Authorization: Basic a2tANGlyZWxhYnMuY29tOmluc2lkZTkw' \
  -H 'Cache-Control: no-cache' \
  -H 'cache-control: no-cache'
```
1. Get uptime
---
```
curl -X GET \
  https://api.pingdom.com/api/2.1/summary.average/{check_id}?includeuptime=true \
  -H 'Accept: */*' \
  -H 'App-Key: 2dorjf2ktnhor0g71e6cdocjzeidznyz' \
  -H 'Authorization: Basic a2tANGlyZWxhYnMuY29tOmluc2lkZTkw' \
  -H 'Cache-Control: no-cache' \
  -H 'cache-control: no-cache'
```

Consumer contract
===
Consumer address: `0xcef1e74b480ba0a312439c5be3f09ec14215ad45`


Job Spec
===
```
{
  "initiators": [
    {
      "type": "runlog",
      "params": {
        "address": "0xc7012b76c58d1e9494e58989a8c092e742ae69f8"
      }
    }
  ],
  "tasks": [
    {
      "type": "httpget",
      "params": {
        "headers": {
          "App-Key": [
            "2dorjf2ktnhor0g71e6cdocjzeidznyz"
          ],
          "Authorization": [
            "Basic a2tANGlyZWxhYnMuY29tOmluc2lkZTkw"
          ],
          "Cache-Control": [
            "no-cache"
          ],
          "cache-control": [
            "no-cache"
          ]
        }
      }
    },
    {
      "type": "jsonparse",
      "params": {
        
      }
    },
    {
      "type": "EthUint256",
      "params": {
        
      }
    },
    {
      "type": "ethtx",
      "params": {
        
      }
    }
  ] 
}
```

```
6944444444444444
```