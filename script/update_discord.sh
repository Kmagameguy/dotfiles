#!/bin/sh

cd $(dirname "$0")

ansible-playbook update_discord.yml --ask-become-pass
