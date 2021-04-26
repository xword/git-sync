#!/bin/sh

set -e

mkdir -p /root/.ssh

if [[ -n "$SSH_PRIVATE_KEY" ]]; then
  echo "$SSH_PRIVATE_KEY" | sed 's/\\n/\n/g' >/root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa
fi

if [[ -n "$SOURCE_SSH_PRIVATE_KEY" ]]; then
  echo "$SOURCE_SSH_PRIVATE_KEY" | sed 's/\\n/\n/g' >/root/.ssh/src_rsa
  chmod 600 /root/.ssh/src_rsa
fi

if [[ -n "$DESTINATION_SSH_PRIVATE_KEY" ]]; then
  echo "$DESTINATION_SSH_PRIVATE_KEY" | sed 's/\\n/\n/g' >/root/.ssh/dst_rsa
  chmod 600 /root/.ssh/dst_rsa
fi

mkdir -p ~/.ssh
cp /root/.ssh/* ~/.ssh/ 2>/dev/null || true

sh -c "/git-sync.sh $*"
