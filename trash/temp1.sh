#!/bin/bash

echo "start temp1"

if [[ "$1" =~ "apt" ]]; then
    echo "This is the first one: " $1
fi

echo "end temp1"
