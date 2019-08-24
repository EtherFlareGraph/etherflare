#!/bin/bash
cd chainlink-ropsten && docker run -p 6688:6688 -v chainlink-ropsten:/chainlink -it --env-file=.env smartcontract/chainlink local n