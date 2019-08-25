## Inspiration
We were inspired by the `Big Short` movie. We think that if some lovely people will insure some evil corporation's website uptime (like facebook) and then this token will be sold on the secondary market hackers will be incentivized to drop uptime to earn some bounties. 
(Haha, we're joking of course) 

We're inspired with Skin-In-The-Game approach, and love to think about new types of business models that we can build having such a powerful instrument like programmable money.

## What it does
EtherFlare can issue for you the DDoS token wired with some website's uptime. Token is issued on behalf of any DDoS protection company (like CloudFlare).  Depending on the uptime for the last 30 days, you can sell this token back to the protecting company for more money (if there was unexpected downtime) of for less (if the downtime was in the normal limits)

## How I built it
We built:
- solidity smart-contract
- chainlink job spec and consumer contract
- deployed chainlink oracle and ran own chainlink node
- wrote a very ugly but hacker-like landing page that is not connected to the smart contract
- spend 2 or 3 times more time with Ropsten then if we chose Rinkeby. (Developer's environment first!!)

## Challenges I ran into
- Lack of documentation of chainlink (of course it's web3, we know how to deal with that!)
- Error in the front-end code of chainlink code (sent bug report to chainlink team)
- Constraints of chainlink APIs
- Ropstend is too low

## Accomplishments that I'm proud of
- We created one more tool that connects blockchain to off-chain world!
- I believe that in a couple of lawyers firms will hire developers who will program their paper-contracts on-chain, and it's possible right now! Hah SLA agreement is bullshit if it's not programmed and deployed on-chain. CODE IS A LAW!

## What I learned
- How to work with chainlink
- What oracles are
- Don't use Ropsten any more

## What's next for EtherFlare
- We will publish it to production and maybe write to somebody from cloud-flare or create DDoS protection service ourselves

Technical Stuff
===

DDOS Token
---
`address`: `0x7ba6f306be7107340f12d8e3a38fb41e5cb97575`


Oracle
---
Oracle contract address: `0xc7012b76c58d1e9494e58989a8c092e742ae69f8`
Link: `0x20fe562d797a42dcb3399062ae9546cd06f63280`
Deployed from: `0xB5dc4847bCE62f2873ce681ffc13fC3D5E6E8d74`
Chain: `ropsten`
Node address: `0xE84a93d372CbAe15BE56a07C602F7a1bE6FB6Ea3`

Pingdom
---
application id: `2dorjf2ktnhor0g71e6cdocjzeidznyz`
pingdom api base url: `https://api.pingdom.com`
login: `your login`
pass: `your pass`


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