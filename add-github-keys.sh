#!/bin/sh

curl https://api.github.com/users/dterei/keys \
  | grep key \
  | sed -e 's/^\s*"key": "//' \
  | sed -e 's/"$//' >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

