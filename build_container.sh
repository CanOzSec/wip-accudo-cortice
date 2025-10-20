#!/bin/bash


docker build -t "accudo-cortice" .
mkdir -p /opt/config/certs
cp config/krb5.conf /opt/config/
cp config/Responder.conf /opt/config/
openssl genrsa -out /opt/config/certs/responder.key 2048
openssl req -new -x509 -days 3650 -key /opt/config/certs/responder.key -out /opt/config/certs/responder.crt -subj "/"
