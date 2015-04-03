#!/bin/bash

MACHINES="\
  davidt@davidt.scs.stanford.edu \
  davidt@black.davidterei.com \
  davidt@silver.davidterei.com \
  davidt@market.scs.stanford.edu \
  davidt@ghcio.scs.stanford.edu \
  davidt@tezzer.scs.stanford.edu"

PKEY=$1

if [[ "$#" -ne 1 ]] || [[ -z $PKEY ]]; then
  echo "Usage: $0 [public key]"
  exit 0
fi

if ! [[ -f ${PKEY} ]]; then
  echo "Invalid public key!"
  exit 1
fi

for m in ${MACHINES}; do
  if [[ $m =~ "@${HOSTNAME}" ]]; then
    continue;
  fi
  ssh-copy-id -i ${PKEY} $m
done

