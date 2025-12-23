#!/bin/sh

warning=70
critical=85

temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)

if [ -z "$temp" ]; then
	echo "{\"text\":\"GPU N/A\"}"
else
	class=""
	if [ "$temp" -ge "$critical" ]; then
		class="critical"
	elif [ "$temp" -ge "$warning" ]; then
		class="warning"
	fi
	
	echo "{\"text\":\"${temp}°C\", \"class\":\"$class\"}"
fi
