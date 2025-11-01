# Smarthome Metrics Temperature

Ruby / Rack application exposing FritzBox thermostats as metrics for prometheus.

## Config:

Available Environment Variables:

| **Name** | **Description** | **Default** |
| - | - | - |
| `FRITZBOX_ENDPOINT` | URL to your FritzBox | `https://fritz.box` |
| `FRITZBOX_USERNAME` | Username to login to your FritzBox | `smarthome` |
| `FRITZBOX_PASSWORD` | Passwort to login to your FritzBox | `verysmart` |
| `FRITZBOX_VERIFY_SSL` | Check the FritzBox's SSL cert | `false`

