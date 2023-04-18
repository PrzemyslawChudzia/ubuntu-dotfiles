#! /usr/bin/env bash

set -eu

currentOutput=$(pactl info | grep "Default Sink: " | awk '{ print $3 }')


headphonesOutputName=$(pactl list sinks short | grep $1 | awk '{print $2}')
speakersOutputName=$(pactl list sinks short | grep $2 | awk '{print $2}')

if [ $currentOutput == $headphonesOutputName ]; then
    newOutput=$speakersOutputName
else
    newOutput=$headphonesOutputName
fi

pacmd set-default-sink $newOutput

while read stream; do
    if [ -z "$stream" ]; then
        break
    fi

    streamId=$(echo $stream | awk '{ print $1 }')
    pactl move-sink-input $streamId @DEFAULT_SINK@
done <<< "$(pactl list short sink-inputs)"
