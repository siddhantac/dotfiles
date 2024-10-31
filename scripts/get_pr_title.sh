#!/bin/bash

link=$(pbpaste)
token=$(grep -o 'GITHUB_TOKEN.*' ~/.aliases.local | sed -E "s/.*=(.*)/\\1/")
display=$(echo $link | rg "deliveryhero/(.*)/pull" -or '$1')
echo $(GITHUB_TOKEN=${token} gh pr view $link --json author,title  --jq  '"\(.author.login) | \(.title)"' ) \[$display\]\($link\)
