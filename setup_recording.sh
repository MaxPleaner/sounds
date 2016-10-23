pacmd list-sinks | grep -A1 "* index"
DEFAULT_OUTPUT=$(pacmd list-sinks | grep -A1 "* index" | grep -oP "<\K[^ >]+")
echo $DEFAULT_OUTPUT

#pactl load-module module-combine-sink \
#  sink_name=record-n-play slaves=$DEFAULT_OUTPUT \
#  sink_properties=device.description="Record-and-Play"

# pactl move-sink-input $DEFAULT_OUTPUT record-n-play
