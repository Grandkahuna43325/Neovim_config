#!/bin/bash

while getopts ":gc" opt; do
  case $opt in
    g)
      xdotool key Control_L+Shift+T
      sleep 1
      echo "$github_username" | xclip -selection c 
      sleep 1
      xdotool type "git push"
      sleep 1
      xdotool key Return
      sleep 1
      xdotool key Control_L+Shift+v
      sleep 1
      echo "$github_token" | xclip -selection c 
      sleep 1
      xdotool key Control_L+Shift+v
      sleep 1
      xdotool type exit
      sleep 1
      xdotool key Return
      ;;
    c) 
      xdotool key Control_L+Shift+T
      sleep 1
      xdotool type "git add ."
      xdotool key Return
      xdotool type "git commit"
      xdotool key Return
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

exit 0
