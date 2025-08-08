#!/bin/sh

# If this doesnt work, gps might be using the wrong device.
# killall gpsd 2>/dev/null
# dmesg | grep tty
# this should should a device name like below.
# gpsd /dev/ttyACM0 -F /var/run/gpsd.sock

# === Config ===
IFNAME="mesh0"
PING_IP="192.168.1.1"
OUTDIR="/tmp/distance"
TS_FILE=$(date +%Y%m%d-%H%M%S)
CSV="$OUTDIR/$TS_FILE.csv"

# === Ensure output dir exists ===
mkdir -p "$OUTDIR"

# === Add CSV header ===
echo "timestamp,time,lat,lon,signal_dbm,noise_dbm,snr_db,tx_mcs,rx_mcs,connected" > "$CSV"

while true; do
    # === Get timestamp and time ===
    TS=$(date -Iseconds 2>/dev/null || date +"%Y-%m-%dT%H:%M:%S%z")
    TIME=$(date +%H:%M:%S)

    # === Get GPS ===
    GPS=$(gpspipe -w -n 30 | grep TPV | grep -m1 lat)
    LAT=$(echo "$GPS" | grep -o '"lat":[^,]*' | cut -d':' -f2 | tr -d ' ')
    LON=$(echo "$GPS" | grep -o '"lon":[^,]*' | cut -d':' -f2 | tr -d ' ')

    # Skip if no GPS fix
    if [ -z "$LAT" ] || [ -z "$LON" ]; then
        echo "[$TIME] No GPS fix. Skipping..."
        sleep 10
        continue
    fi

    # === Get Signal and Noise ===
    STATS=$(morse_cli -i "$IFNAME" stats)
    RSSI=$(echo "$STATS" | grep "Received Power (dBm)" | awk -F':' '{print $2}' | xargs)
    NOISE=$(echo "$STATS" | grep "Noise dBm" | awk -F':' '{print $2}' | xargs)
    SNR=$(( RSSI - NOISE ))

    # === Get TX/RX MCS ===
    TX_MCS=$(iw dev "$IFNAME" station dump 2>/dev/null | grep "tx bitrate" | grep -oE 'MCS [0-9]+' | head -n1 | cut -d' ' -f2)
    RX_MCS=$(iw dev "$IFNAME" station dump 2>/dev/null | grep "rx bitrate" | grep -oE 'MCS [0-9]+' | head -n1 | cut -d' ' -f2)

    TX_MCS=${TX_MCS:-NA}
    RX_MCS=${RX_MCS:-NA}

    # === Ping test for connectivity ===
    if ping -c 1 -W 1 "$PING_IP" >/dev/null 2>&1; then
        STATUS="yes"
        echo "✅ Ping $PING_IP OK"
    else
        STATUS="no"
        echo "❌ Ping $PING_IP failed"
    fi

    # === Output to console and CSV ===
    echo "Logged at $TIME ($LAT, $LON) RSSI=$RSSI dBm, SNR=$SNR dB, TX_MCS=$TX_MCS, RX_MCS=$RX_MCS, Connected=$STATUS"
    echo "$TS,$TIME,$LAT,$LON,$RSSI,$NOISE,$SNR,$TX_MCS,$RX_MCS,$STATUS" >> "$CSV"

    sleep 10
done
