#!/bin/bash

openssl genrsa -out private.pem 1024
openssl rsa -in private.pem -out public.pem -pubout -outform PEM

exit 0
