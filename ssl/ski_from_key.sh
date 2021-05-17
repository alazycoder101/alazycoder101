#!/bin/bash
# Subject Key Identifier
openssl rsa -in $1  -pubout | openssl asn1parse -strparse 19 -noout -out - | openssl dgst -c -sha1
