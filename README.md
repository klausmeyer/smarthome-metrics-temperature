# Smarthome Metrics Temperature

Ruby / Rack application exposing FritzBox thermostats as metrics for prometheus.

## Config:

Available Environment Variables:

* `FRITZBOX_ENDPOINT`:<br>
  URL to your FritzBox (Default: `https://fritz.box`)
* `FRITZBOX_USERNAME`:<br>
  Username to login to your FritzBox (Default: `smarthome`)
* `FRITZBOX_PASSWORD`:<br>
  Passwort to login to your FritzBox (Default: `verysmart`)
* `FRITZBOX_VERIFY_SSL`:<br>
  Check the FritzBox's SSL cert (Default: `false`)

