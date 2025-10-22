#!/bin/bash

# Get ESSID of active interface - use 'iw dev [iface] link' for reliable SSID
wifi_interface=$(iw dev 2>/dev/null | awk '/Interface/ {print $2; exit}')
if [ -n "$wifi_interface" ]; then
    essid=$(iw dev "$wifi_interface" link 2>/dev/null | awk '/SSID:/ {print $2}')
else
    essid=""
fi
essidlength=${#essid}

# Handle no WiFi case
if [ -z "$essid" ]; then
    display_essid="NoWiFi"
elif [ $essidlength -lt 9 ]; then
    display_essid=$essid
else
    display_essid=$(echo $essid | cut -c 1-8)..
fi

# Cache file for IP address
IP_CACHE="/tmp/conky_ip_cache"
IP_CACHE_AGE=30  # Refresh IP every 30 seconds

# Check if cache exists and is recent
if [ -f "$IP_CACHE" ] && [ $(($(date +%s) - $(stat -c %Y "$IP_CACHE" 2>/dev/null || echo 0))) -lt $IP_CACHE_AGE ]; then
    # Use cached IP
    ip=$(cat "$IP_CACHE")
else
    # Get external IP (with timeout and silent flags)
    ip=$(curl -4 -s --max-time 2 ifconfig.me 2>/dev/null)

    # Validate that we got an actual IP address (IPv4 format)
    if [[ ! "$ip" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        # Invalid IP format (possibly HTML from captive portal)
        ip=""
    fi

    # If curl fails or returns empty/invalid, try to use last known IP
    if [ -z "$ip" ] && [ -f "$IP_CACHE" ]; then
        ip=$(cat "$IP_CACHE")
        # Validate cached IP too
        if [[ ! "$ip" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
            ip=""
        fi
    elif [ -n "$ip" ]; then
        # Save valid IP to cache
        echo "$ip" > "$IP_CACHE"
    fi
fi

# If still no IP, show placeholder
[ -z "$ip" ] && ip="..."

# Sanitize output for JSON safety - remove any problematic characters
# Keep only alphanumeric, dots, spaces, and basic punctuation (including #)
# Note: # is safe for i3bar JSON when not starting a comment line
safe_essid=$(echo "$display_essid" | tr -cd '[:alnum:][:space:].-_#')
safe_ip=$(echo "$ip" | tr -cd '[:alnum:].')

# Output for Conky - ensure clean output with no special characters
echo -n "$safe_essid $safe_ip"

