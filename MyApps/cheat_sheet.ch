#!/usr/bin/env bash

languages=`echo "java bash c javascript" | tr " " "\n"`
core_utils=`echo "find sed awk" | tr " " "\n"`

selected=`printf "$languages\n$core_utils" | fzf --prompt="select language or command: > "`
read -p "query: " query

if printf $languages | grep -qs $selected; then
  curl cht.sh/$selected/`echo $query | tr " " "+"`
else
  curl cht.sh/$selected~$query
fi

