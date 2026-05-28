# General information

On UNO Q need separate firmware for accessing MCU and RFID readers using spi/i2c as those pins are not easily accessible
from MPU/Linux side. To start work on this implementation will be provided first as binary simple driver exposing endpoints
available through rpc (see arduino bridge router) that can be used with MsgPack RPC.

# Design information and architecture

Endpoints registered on rpc daemon are of 2 types
Signals, that are fired up and Publishers don't get information if it reaches and no return is expected.
Methods. This can call remote procedure and provide return.

## RPC calls 
Firmware will provide 2 methods
getCard which will return string containing recent card uid or empty string if no recent card is available
getReaderVersion returns firmware version, used mostly to check if firmware is working and rfid reader is available.

Firmware will send signal
notifyNewCardPresent when card is available and is new( this means. Card uid is different then last read or  some time from last registration passed and this card is consider new for swipe mechanism)