#!/bin/bash

SSH_PRIVATE_KEY=$1
DOKKU_USER=$2
DOKKU_HOST=$3
DOKKU_COMMAND=$4

# Setup the SSH environment
echo "[###] Setup the SSH environment..."
mkdir -p ~/.ssh
eval `ssh-agent -s`
ssh-add - <<< "$SSH_PRIVATE_KEY"
ssh-keyscan $DOKKU_HOST >> ~/.ssh/known_hosts

SSH="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
DOKKU="$SSH $DOKKU_USER@$DOKKU_HOST"

echo "[###] Executing command"
$DOKKU $DOKKU_COMMAND

