#!/bin/sh
# Cycle the default audio output+input across three device combos:
#   Speakers + Brio  ->  GameBuds  ->  Space 2 + Brio  ->  ...
set -u

SPEAKERS=alsa_output.pci-0000_00_1f.3.analog-stereo
EARBUDS=alsa_output.usb-SteelSeries_Arctis_GameBuds_X-00.analog-stereo
EARBUDS_MIC=alsa_input.usb-SteelSeries_Arctis_GameBuds_X-00.mono-fallback
BRIO_MIC=alsa_input.usb-046d_Brio_101_2433AP05NRY8-02.mono-fallback
SPACE2_MAC=84_9D_4B_EC_E7_D8

# The bluez sink name carries the active profile index (bluez_output.<mac>.1),
# which changes when the headset renegotiates its profile — resolve by MAC.
SPACE2=$(pactl list short sinks | cut -f2 | grep -m1 "^bluez_output\.${SPACE2_MAC}\.")

exists() {
    [ -n "$1" ] && pactl list short "$2" | cut -f2 | grep -qxF "$1"
}

cur=$(pactl get-default-sink)
case "$cur" in
    "$SPEAKERS") order="earbuds space2 speakers" ;;
    "$EARBUDS")  order="space2 speakers earbuds" ;;
    *)           order="speakers earbuds space2" ;;
esac

newsink=
for target in $order; do
    case "$target" in
        speakers) newsink=$SPEAKERS; newsource=$BRIO_MIC;    label="Speakers + Brio" ;;
        earbuds)  newsink=$EARBUDS;  newsource=$EARBUDS_MIC; label="GameBuds" ;;
        space2)   newsink=$SPACE2;   newsource=$BRIO_MIC;    label="Space 2 + Brio" ;;
    esac
    exists "$newsink" sinks && break
    newsink=
done

if [ -z "$newsink" ]; then
    notify-send "Audio Device" "No known output available"
    exit 1
fi

pactl set-default-sink "$newsink"
pactl list short sink-inputs | cut -f1 | xargs -r -I{} pactl move-sink-input {} "$newsink"

if exists "$newsource" sources; then
    pactl set-default-source "$newsource"
    pactl list short source-outputs | cut -f1 | xargs -r -I{} pactl move-source-output {} "$newsource"
else
    label="$label (mic unavailable)"
fi

notify-send "Audio Device" "Switched to $label"
