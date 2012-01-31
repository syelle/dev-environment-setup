#!/usr/bin/env bash

if [ $(id -u) -eq 0 ]
then
echo 'ERROR: This script should not be run as sudo or root.'
  exit
fi

if [ -v $1 ]
then
echo 'Please provide the domain for which the cert should be named.'
  exit
fi

# From: http://www.akadia.com/services/ssh_test_certificate.html
openssl genrsa -des3 -out $1.key 1024
openssl req -new -key $1.key -out $1.csr
cp $1.key $1.key.orig
openssl rsa -in $1.key.orig -out $1.key
openssl x509 -req -days 365 -in $1.csr -signkey $1.key -out $1.crt
