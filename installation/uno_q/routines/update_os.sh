#!/usr/bin/env bash

_run_update_os() {
    sudo apt-get -qq -y update && sudo apt-get -qq -y full-upgrade || exit_on_error "Failed to Update OS"
    if [ "$CI_RUNNING" != "true" ]; then
        sudo apt-get -qq -y autoremove
    fi
}

update_os() {
    if [ "$UPDATE_RASPI_OS" == true ]; then
        run_with_log_frame _run_update_os "Updating OS"
    fi
}
