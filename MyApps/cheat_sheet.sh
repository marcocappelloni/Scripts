#!/usr/bin/env bash

# languages=`echo "bash c html java javascript markdown python sql" | tr " " "\n"`
# core_utils=`echo "awk bash cat find sed fzf" | tr " " "\n"`

# selected=`printf "$languages\n$core_utils" | fzf --prompt="select cheat sheet topic: > "`
selected=`cht.sh :list | fzf --layout=reverse --border=bold --border=rounded --margin=3% --color=border:#225577 --prompt="select cheat sheet topic: > "`
read -p "query: " query

cht.sh $selected $query
# if printf $languages | grep -qs $selected; then
#  curl cht.sh/$selected/`echo $query | tr " " "+"`
# else
#  curl cht.sh/$selected~$query
# fi

