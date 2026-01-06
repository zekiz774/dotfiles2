# switch TV monitor on and main monitor off
hyprctl keyword monitor HDMI-A-1, 3840x2160@120.00Hz, auto, 1, vrr, 2, bitdepth, 10
hyprctl keyword monitor DP-3, disable

# set audio device
CURRENT_SINK=$(pactl get-default-sink)
CURRENT_VOLUME=$(pactl -f json get-sink-volume $CURRENT_SINK | jq '.volume["front-left"].value')

MONITOR_SINK=alsa_output.pci-0000_03_00.1.hdmi-stereo-extra3
(
  sleep 1
  pactl set-default-sink $MONITOR_SINK
) &
pactl set-sink-volume $MONITOR_SINK 150%

# start gamescope
ENABLE_HDR_WSI=1 gamescope --fullscreen -w 3840 -h 2160 --hdr-enabled --hdr-debug-force-output --hdr-sdr-content-nits 600 --mangoapp -- env ENABLE_GAMESCOPE_WSI=1 DXVK_HDR=1 DISABLE_HDR_WSI=1 steam -tenfoot

# reset after gs closed

pactl set-default-sink $CURRENT_SINK
pactl set-sink-volume $CURRENT_SINK $CURRENT_VOLUME

hyprctl reload
