#!/bin/bash

# Configuration script for Phonieboxi8 on Arduino UNO Q
# Optimized for PipeWire/PulseAudio headless control

_setup_autologin() {
print_lc " Setup autologin and linger for Uno Q."

# 1. Switch to text mode (disable GUI)
log "Setting default target to multi-user.target..."
sudo systemctl set-default multi-user.target

# 2. Configure terminal autologin
log "Configuring autologin for user $CURRENT_USER on tty1..."
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/
cat <<EOF | sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $CURRENT_USER --noclear %I \$TERM
EOF

# 3. Enable user lingering
log "Enabling lingering for user $CURRENT_USER..."
sudo loginctl enable-linger $CURRENT_USER

# 4. Add user to critical groups
log "Updating user groups..."
sudo usermod -a -G audio,bluetooth,dialout "$CURRENT_USER"

}

_setup_envvars() {
# 6. Add Environment Variables to .bashrc for PulseAudio compatibility
print_lc "Adding PulseAudio environment variables to .bashrc..."
if ! grep -q "PULSE_SERVER" "/home/$CURRENT_USER/.bashrc"; then
  echo "export XDG_RUNTIME_DIR=/run/user/\$(id -u)" >>"/home/$CURRENT_USER/.bashrc"
  echo "export PULSE_SERVER=unix:/run/user/\$(id -u)/pulse/native" >>"/home/$CURRENT_USER/.bashrc"
fi
}

_setup_wireplumber_config() {
  # Copy config file increasing bluetooth speakers
}

_setup_unoq_os() {
  _setup_autologin
  _setup_envvars
  _setup_wireplumber_config
}

setup_unoq_os() {
  run_with_log_frame _setup_unoq_os "Make Uno Q specific changes"
}