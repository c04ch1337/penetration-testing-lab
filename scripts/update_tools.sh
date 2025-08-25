#!/bin/bash

echo "🔄 Updating all tools..."

# Update system packages first
echo "📦 Updating system packages..."
sudo apt-get update
sudo apt-get upgrade -y

# Update Metasploit
echo "📦 Updating Metasploit..."
cd /opt/metasploit-framework
git pull
bundle install

# Update Nikto
echo "📦 Updating Nikto..."
cd /opt/nikto
git pull
perl nikto.pl -update

# Update Nmap (check if we need to rebuild from source)
echo "📦 Checking Nmap updates..."
current_ver=$(nmap --version 2>/dev/null | head -1 | grep -oE '[0-9]+\.[0-9]+')
latest_ver="7.94"

if [ "$(printf '%s\n' "$latest_ver" "$current_ver" | sort -V | head -n1)" != "$latest_ver" ]; then
    echo "🔄 New Nmap version available, updating..."
    cd /tmp
    wget https://nmap.org/dist/nmap-${latest_ver}.tar.bz2
    tar xjf nmap-${latest_ver}.tar.bz2
    cd nmap-${latest_ver}
    ./configure --prefix=/usr/local --without-zenmap
    make -j$(nproc)
    sudo make install
    rm -rf /tmp/nmap-*
fi

# Update package manager versions too
sudo apt-get install --only-upgrade -y nmap nikto

echo "✅ All tools updated successfully!"
echo ""
echo "📋 Current versions:"
echo "   Nmap: $(nmap --version 2>/dev/null | head -1 || echo 'Unknown')"
echo "   Metasploit: $(msfconsole --version 2>/dev/null | head -1 || echo 'Unknown')"
echo "   Nikto: $(nikto -version 2>/dev/null | head -1 || echo 'Unknown')"
