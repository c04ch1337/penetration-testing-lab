cat > stealth-config/system-tweaks.sh << 'EOF'
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

# Disable common services that reveal OS info
sudo systemctl mask systemd-udev-settle.service 2>/dev/null || true

# Modify package manager fingerprints
sudo mkdir -p /etc/apt/apt.conf.d/
echo 'Acquire::http::User-Agent "Debian APT-HTTP/1.3 (1.0)";' | sudo tee /etc/apt/apt.conf.d/99stealth

# Clean system logs
sudo find /var/log -type f -exec truncate -s 0 {} \; 2>/dev/null || true

# Remove history files
rm -f ~/.bash_history ~/.msf4/history ~/.nmap_history 2>/dev/null || true

# Create fake system files to mimic regular Ubuntu server
sudo mkdir -p /etc/update-motd.d/
echo "#!/bin/bash" | sudo tee /etc/update-motd.d/00-header >/dev/null
echo "echo 'Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-86-generic x86_64)'" | sudo tee -a /etc/update-motd.d/00-header >/dev/null

# Modify os-release to look like Ubuntu
sudo cp /etc/os-release /etc/os-release.backup
cat << 'OS_RELEASE' | sudo tee /etc/os-release >/dev/null
NAME="Ubuntu"
VERSION="20.04.6 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.6 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
OS_RELEASE

echo "✅ Stealth configurations applied!"
echo "   System now appears as: Ubuntu 20.04.6 LTS"
EOF
