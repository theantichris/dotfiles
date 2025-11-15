temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)

if [ -z "$temp" ]; then
	echo "GPU N/A"
else
	echo "${temp}°C"
fi
