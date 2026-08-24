#!/usr/bin/with-contenv bashio

# ==============================================================================
# run.sh - GPSd haOS add-on
# Starts gpsd in foreground mode with options from the add-on configuration.
# ==============================================================================

declare device
declare baud
declare gpsd_options

# Read add-on options
device=$(bashio::config 'device')
baud=$(bashio::config 'baud')
gpsd_options=$(bashio::config 'gpsd_options')

# Validate the device exists
if [[ ! -e "${device}" ]]; then
  bashio::log.fatal "GPS device not found: ${device}"
  bashio::log.fatal "Check your device path. Common paths:"
  bashio::log.fatal "  /dev/ttyUSB0"
  bashio::log.fatal "  /dev/ttyACM0"
  bashio::log.fatal "  /dev/serial/by-id/usb-..."
  bashio::exit.nok
fi

if ! stty -F "${device}" "${baud}" raw -echo; then
  bashio::log.warning "Unable to preconfigure device ${device} for baud rate ${baud}; continuing..."
fi

bashio::log.info "Starting gpsd..."
bashio::log.info "  Device:  ${device}"
bashio::log.info "  Baud:    ${baud}"
bashio::log.info "  Options: ${gpsd_options}"

# Start gpsd in foreground
#   -N  Do not daemonize (stay in foreground)
#   -G  Listen on all interfaces (allow remote clients)
#   -S  Set the TCP port
#   -b  Read-only mode (do not write to GPS device)
#   -s  Set baud rate
# shellcheck disable=SC2086
exec gpsd -N -G -S 2947 -b -s "${baud}" ${gpsd_options} "${device}"
