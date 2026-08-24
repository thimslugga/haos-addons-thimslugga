# GPSd

This app runs `gpsd` against a USB serial GPS receiver and exposes it on TCP
port `2947`.

## Recommended device path

Prefer a stable path under `/dev/serial/by-id/` when available, for example:

`/dev/serial/by-id/usb-u-blox_AG_-_www.u-blox.com_u-blox_7_-_GPS_GNSS_Receiver-if00`

## Configuration

- `device`: serial device path for the GPS receiver
- `baud`: serial baud rate, usually `9600`
- `gpsd_options`: additional `gpsd` flags

Default options:

```yaml
device: /dev/ttyACM0
baud: 9600
gpsd_options: "-n -b -G"
```

## Home Assistant integration

After starting the app:

1. Open `Settings -> Devices & Services`
2. `Add Integration`
3. Search `GPSD`
4. Use:
   - Host: the app hostname shown on the app page (for example `0d84d441-gpsd`)
   - Port: `2947`

Do not use `127.0.0.1` here. The integration runs in Home Assistant Core and
should connect to the GPSD app over the internal app network.
