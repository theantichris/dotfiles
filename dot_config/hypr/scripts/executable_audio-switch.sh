#!/bin/bash
# Toggle between speakers/Brio mic and Arctis GameBuds

SPEAKERS="alsa_output.pci-0000_00_1f.3.analog-stereo"
EARBUDS="alsa_output.usb-SteelSeries_Arctis_GameBuds_X-00.analog-stereo"
BRIO_MIC="alsa_input.usb-046d_Brio_101_2433AP05NRY8-02.mono-fallback"
EARBUDS_MIC="alsa_input.usb-SteelSeries_Arctis_GameBuds_X-00.mono-fallback"

current=$(pactl get-default-sink)

if [[ "$current" == "$SPEAKERS" ]]; then
    next_sink="$EARBUDS"
    next_source="$EARBUDS_MIC"
    name="Arctis GameBuds"
else
    next_sink="$SPEAKERS"
    next_source="$BRIO_MIC"
    name="Speakers + Brio"
fi

pactl set-default-sink "$next_sink"
pactl set-default-source "$next_source"

# Move all playing streams to the new sink
pactl list short sink-inputs | while read -r stream _; do
    pactl move-sink-input "$stream" "$next_sink" 2>/dev/null
done

notify-send -t 2000 "Audio" "$name"
