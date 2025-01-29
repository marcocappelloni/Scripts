#!/bin/bash

sw_list_base="./softwares_lists/base"
source test_lib.sh $sw_list_base
#create_softwares_to_install_array $sw_list_base
#sw_to_install=$create_softwares_to_instsall_array
echo "List: ${sw_to_install[*]}"
