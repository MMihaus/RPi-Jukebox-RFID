#!/bin/bash

# Configuration script for Phoniebox on Arduino UNO Q
# Optimized for PipeWire/PulseAudio headless control

USER_NAME="arduino"

echo "--- Starting OS configuration for UNO Q ---"

# 1. Update and install audio/bluetooth dependencies
echo "Installing PipeWire, PulseAudio compatibility and Bluetooth tools..."
sudo apt update
sudo apt install -y \
  pipewire \
  pipewire-pulse \
  wireplumber \
  libpulse0 \
  pactl \
  bluez \
  pipewire-audio-client-libraries \
  pipewire-module-bluetooth

# 2. Switch to text mode (disable GUI)
echo "Setting default target to multi-user.target..."
sudo systemctl set-default multi-user.target

# 3. Configure terminal autologin
echo "Configuring autologin for user $USER_NAME on tty1..."
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/
cat <<EOF | sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $USER_NAME --noclear %I \$TERM
EOF

# 4. Enable user lingering
echo "Enabling lingering for user $USER_NAME..."
sudo loginctl enable-linger $USER_NAME

# 5. Add user to critical groups
echo "Updating user groups..."
sudo usermod -a -G audio,bluetooth,dialout $USER_NAME

# 6. Enable PipeWire and PulseAudio bridge as user services
echo "Enabling PipeWire services for user session..."
sudo -u $USER_NAME systemctl --user enable pipewire pipewire-pulse wireplumber

# 7. Add Environment Variables to .bashrc for PulseAudio compatibility
echo "Adding PulseAudio environment variables to .bashrc..."
if ! grep -q "PULSE_SERVER" "/home/$USER_NAME/.bashrc"; then
  echo "export XDG_RUNTIME_DIR=/run/user/\$(id -u)" >>"/home/$USER_NAME/.bashrc"
  echo "export PULSE_SERVER=unix:/run/user/\$(id -u)/pulse/native" >>"/home/$USER_NAME/.bashrc"
fi

# 8. Finalize
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "--- Configuration finished! ---"
echo "A reboot is recommended: sudo reboot"
