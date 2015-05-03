### Quadcopter Wifi communication using an esp8266 ###

This LUA code runs on an esp8266 running nodeMCU firmware. It is meant to communicate with an atmel328p based board over serial.

## Setup ##

In this project I am using the esp8266 (esp03) wifi module. Pin connections are as follows:
    
    VCC --> 3.3V
    GND --> GND
    RX --> TX
    TX --> RX
    CH_PD --> 3.3V
    GPIO0 --> Floating
    GPIO15 --> GND
    GPIO2 --> Floating

For flashing:

    GPIO2 --> 3.3V

## Installation ##

I am using ESPlorer v0.2.0 to communicate with the ESP8266 over serial. The following files must be uploaded to the board:

    init.lua
    helpers.lua
    flight.lua
    main.lua

After the files have been uploaded a reset should be performed.