#!/bin/bash
disp=$(xrandr -q | grep " connected" | sed -e 's/ .*$//' | head -1)
xrandr --output $disp --primary
