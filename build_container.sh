#!/bin/bash


docker build -t "rutila-corium" .
mkdir -p /opt/rutila-corium/config/certs
cp config/krb5.conf /opt/rutila-corium/config/
cp config/Responder.conf /opt/rutila-corium/config/
cp config/environment.conf /opt/rutila-corium/config/
openssl genrsa -out /opt/rutila-corium/config/certs/responder.key 2048
openssl req -new -x509 -days 3650 -key /opt/rutila-corium/config/certs/responder.key -out /opt/rutila-corium/config/certs/responder.crt -subj "/"
