#!/bin/bash


docker build -t "accudo-cortice" .
mkdir -p /opt/accudo-cortice/config/certs
cp config/krb5.conf /opt/accudo-cortice/config/
cp config/Responder.conf /opt/accudo-cortice/config/
cp config/environment.conf /opt/accudo-cortice/config/
openssl genrsa -out /opt/accudo-cortice/config/certs/responder.key 2048
openssl req -new -x509 -days 3650 -key /opt/accudo-cortice/config/certs/responder.key -out /opt/accudo-cortice/config/certs/responder.crt -subj "/"
