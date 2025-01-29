#!/bin/sh

i3-msg exec 'alacritty --working-directory ~/Programming'
i3-msg exec 'alacritty -e ranger ~/Programming'
i3-msg exec chromium https://www.udemy.com/course/the-complete-web-development-bootcamp https://www.appbrewery.co/p/web-development-course-resources/
i3-msg exec code
#i3-msg move container to workspace " 2: Term  "
