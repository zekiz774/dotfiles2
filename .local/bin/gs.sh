#!/usr/bin/env bash
# switch TV monitor on and main monitor off
hyprctl keyword monitor HDMI-A-1, 3840x2160@120.00Hz, auto, 1, vrr, 2, bitdepth, 10
hyprctl keyword monitor DP-3, disable

# set audio device
CURRENT_SINK=$(pactl get-default-sink)
CURRENT_VOLUME=$(pactl -f json get-sink-volume $CURRENT_SINK | jq '.volume["front-left"].value')

# Turn on TV with a remote raspberrypi with cec-ctl installed. SSH key needs to be set up already
(
  ssh raspberrypi@raspberrypi <<'ENDSSH'
cec-ctl --to TV --playback --image-view-on 
sleep 2
cec-ctl --to TV --active-source phys-addr=4.0.0.0 
ENDSSH
) &

#
MONITOR_SINK=alsa_output.pci-0000_03_00.1.hdmi-stereo-extra3
(
  sleep 1
  pactl set-default-sink $MONITOR_SINK
  pactl set-sink-volume $MONITOR_SINK 150%

) &

# start gamescope
pkill steam
ENABLE_HDR_WSI=1 gamescope --fullscreen -w 3840 -h 2160 --hdr-enabled --hdr-debug-force-output --hdr-sdr-content-nits 600 --mangoapp -e -- env ENABLE_GAMESCOPE_WSI=1 DXVK_HDR=1 DISABLE_HDR_WSI=1 steam -tenfoot

# reset after gs closed

#turn off TV
ssh raspberrypi@raspberrypi <<'ENDSSH'
cec-ctl --to TV --standby
ENDSSH

pactl set-default-sink $CURRENT_SINK
pactl set-sink-volume $CURRENT_SINK $CURRENT_VOLUME

hyprctl reload
