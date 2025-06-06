#!/bin/bash

operation=$(echo "list add remove clear exit" | tr " " "\n")
while true; do
  selected_operation=$(echo "$operation" | dmenu -i -l 15 -p "Todo")

  case "$selected_operation" in
  "list")
    todo list | dmenu -l 15 -p "Task list:"
    ;;
  "add")
    task=$("" | dmenu -p "Enter new task:")
    if [ ! -z "${task// /}" ]; then
      todo add $task
      todo list | dmenu -l 15 -p "Task list:"
    fi
    ;;
  "remove")
    selected_task=$(todo list | dmenu -i -l 15 -p "Select task to remove:")
    if [ ! -z "${selected_task// /}" ]; then
      task_index="${selected_task:0:2}"
      todo remove ${task_index#0}
    fi
    ;;
  "clear")
    todo clear
    ;;
  *)
    exit 0
    ;;
  esac

  sleep 0.1
done
