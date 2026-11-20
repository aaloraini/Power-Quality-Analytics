# Power Quality Analytics

An IoT analytics project for BEE3033 Data Communication & Networks at UCSI University. It reads two public ThingSpeak channels every hour, runs power quality calculations on them in MATLAB, and shows the results on a web page.

**Live page:** https://aaloraini.github.io/Power-Quality-Analytics/

## What it does

Two public meters publish their readings to ThingSpeak:

| Source | Channel | Location | Supply |
|---|---|---|---|
| BigMeow UPS monitor (HPE T1500 G5) | [3055790](https://thingspeak.mathworks.com/channels/3055790) | Chile | Single-phase, 220 V, 50 Hz |
| Smartmeter with rooftop PV | [1816602](https://thingspeak.mathworks.com/channels/1816602) | Austria | Three-phase, 230 V, 50 Hz |

A MATLAB Analysis script, triggered every hour by TimeControl, reads the last 60 minutes from both channels, calculates the values below for each reading, averages them, and writes the result to our channel [3590491](https://thingspeak.mathworks.com/channels/3590491).

| Field | Result | Equation |
|---|---|---|
| 1 | UPS apparent power (VA) | S = V × I |
| 2 | UPS power factor | PF = P / S |
| 3 | UPS losses (W) | P_loss = P_out / (η/100) − P_out |
| 4 | UPS voltage deviation (%) | ΔV = (V − 220) / 220 × 100 |
| 5 | Smart meter average phase voltage (V) | V_avg = (V_L1 + V_L2 + V_L3) / 3 |
| 6 | Smart meter voltage unbalance (%) | LVUR = max\|V_Li − V_avg\| / V_avg × 100 |
| 7 | Smart meter voltage deviation (%) | ΔV = (V_avg − 230) / 230 × 100 |
| 8 | Smart meter net power (W) | taken directly from the meter |

## Files

- `index.html`: the web page. It embeds the ThingSpeak charts and fetches the latest values from the channel's public API. No build step.
- `power_quality_analysis.m`: the MATLAB Analysis script (Write API key removed).

## Running it yourself

The page is static, so opening `index.html` in a browser is enough. The charts only load while channel 3590491 is public.

## Team

- Aloraini Abdulhakim
- Mohanad Baqais

Data collection started on 20 November 2026.
