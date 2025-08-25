#!/bin/bash

echo "🕵️  Applying stealth configurations..."

# Change system fingerprints
echo "generic-ubuntu-server" | sudo tee /etc/hostname
sudo hostname generic-ubuntu-server

# Remove Docker metadata
sudo rm -f /.dockerenv /run/.containerenv 2>/dev/null || true

# Modify shell prompt
echo "export PS1='[\u@generic-ubuntu-server \W]\\$ '" | sudo tee -a /etc/bash.bashrc
echo "export PS1='[\u@generic-ubuntu-server \W]\\$ '" >> ~/.bashrc

# Clean system logs
sudo find /var/log -type f -exec truncate -s 0 {} \; 2>/dev/null || true

# Remove history files
rm -f ~/.bash_history 2>/dev/null || true

echo "✅ Stealth configurations applied!"
