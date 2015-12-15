#!/bin/bash

openssl req -new -x509 -days 365 -nodes -out server.cert.pem -keyout server.key.pem

exit 0
