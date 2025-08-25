#!/bin/bash

echo "📦 Installing Nikto..."

# Install additional Perl modules
sudo apt-get install -y --no-install-recommends \
    libnet-ssleay-perl \
    libwhisker2-perl \
    libwww-perl

# Install latest Nikto from git
cd /opt
if [ ! -d "nikto" ]; then
    echo "🔍 Cloning Nikto repository..."
    git clone https://github.com/sullo/nikto.git --depth 1
else
    cd nikto
    echo "🔄 Updating Nikto..."
    git pull
fi

cd /opt/nikto

# Update Nikto database
echo "🔄 Updating Nikto database..."
perl nikto.pl -update 2>/dev/null || echo "⚠️ Nikto database update may have failed"

# Create symbolic link
sudo ln -sf /opt/nikto/program/nikto.pl /usr/local/bin/nikto

echo "✅ Nikto installation attempted!"
