#!/bin/bash
BIN_PATH="${INSTALLATION_PATH}/resources/unoq-specific/mcu-firmware/bin"
#This could be setup during config/setup prompt mostly for choosing version simple vs one with display and buttons.
FIRMWARE_NAME="rfid_testing.ino.bin"
_setup_mcu_fwm(){
    echo "This only uploads test rfid not final version for testin instalation process"
    arduino-cli upload -b arduino:zephyr:unoq -i "${BIN_PATH}/${FIRMWARE_NAME}"
}

_check_firmware_running(){
    #make call to arduino-bridge-cli checking if rfid is working final calls and signals to be defined
    #idea is to have isRunning or getFmwVer.
}

setup_mcu_fmw() {
    run_with_log_frame _setup_mcu_fmw "Upload mcu rfid related code."
}
