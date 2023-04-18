isPaused=$(dunstctl is-paused)

if [ "$isPaused" = true ]; then
    dunstctl set-paused false
    dunstify -u critical "Do not disturb turned off" -t 1000
else
    dunstctl set-paused true
fi
