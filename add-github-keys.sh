#!/bin/sh
# Append this user's public keys from GitHub to authorized_keys,
# skipping any that are already present.

mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys

curl -fsSL https://github.com/dterei.keys | while IFS= read -r key; do
  [ -n "$key" ] || continue
  grep -qxF "$key" ~/.ssh/authorized_keys || echo "$key" >> ~/.ssh/authorized_keys
done

chmod 600 ~/.ssh/authorized_keys
