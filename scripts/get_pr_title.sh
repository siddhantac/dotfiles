#!/bin/bash

token=$(grep -o 'GITHUB_TOKEN.*' ~/.aliases.local | sed -E "s/.*=(.*)/\\1/")
echo $(GITHUB_TOKEN=${token} gh pr view $1 --json author,title  --jq  '"\(.author.login) | \(.title)"' )
