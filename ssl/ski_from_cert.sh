#!/bin/bash
openssl x509  -noout -in $1 -pubkey  | openssl asn1parse  -strparse 19 -noout -out - | openssl dgst -c -sha1
