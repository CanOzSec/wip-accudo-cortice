#!/bin/bash


args="$@"
guiTools="wireshark BurpSuiteCommunity ghidraRun freerdp3 remmina jadx"
for tool in $guiTools; do
	if [[ $0 == *"$tool"* ]]; then
		if [[ -n "$DISPLAY" ]]; then
			xhost +local:*
			guiType="x11"
			gui="-v /tmp/.X11-unix/:/tmp/.X11-unix/ -e DISPLAY=$DISPLAY"
		else
			guiType="wayland"
		fi
	fi;
done


function user_run() {
	docker run -a stdin -a stdout -a stderr  \
	-v $PWD:/opt/host --user "1000:1000" $gui\
	-v /opt/attack/:/opt/attack -w /opt/host \
	--network host --rm -it accudo-cortice $0 $args
}


function root_run() {
	docker run -a stdin -a stdout -a stderr  \
	-v $PWD:/opt/host --user "0:0"	 	 $gui\
	-v /opt/attack/:/opt/attack -w /opt/host \
	--network host --rm -it accudo-cortice $0 $args
}


user_run
