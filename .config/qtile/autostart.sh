#!/bin/sh
nm-applet &
display -window root '/home/edicsonabel/9.jpg' &
xinput --set-prop 12 'libinput Accel Speed' 0.55
xinput --set-prop 12 'libinput Natural Scrolling Enabled' 1
xinput --set-prop 12 'libinput Tapping Enabled' 1
for output in $(xrandr --prop | grep -E -o -i "^[A-Z\-]+-[0-9]+"); do xrandr --output "$output" --set "scaling mode" "Full aspect"; done