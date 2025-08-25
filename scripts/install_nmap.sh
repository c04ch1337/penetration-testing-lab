#!/bin/bash

echo "📦 Installing Nmap..."

# Try to install from package manager first
if sudo apt-get install -y --no-install-recommends nmap; then
    echo "✅ Nmap installed from package manager"
else
    echo "⚠️ Package manager installation failed, trying source..."
    
    # Install build dependencies
    sudo apt-get install -y --no-install-recommends \
        build-essential \
        libpcap-dev \
        liblua5.3-dev \
        liblinear-dev

    # Install from source
    cd /tmp
    echo "📥 Downloading Nmap source..."
    wget -q --timeout=30 https://nmap.org/dist/nmap-7.94.tar.bz2 || \
    wget -q --timeout=30 http://nmap.org/dist/nmap-7.94.tar.bz2 || \
    curl -s -O https://nmap.org/dist/nmap-7.94.tar.bz2 || \
    { echo "❌ Failed to download Nmap"; exit 1; }

    if [ -f "nmap-7.94.tar.bz2" ]; then
        echo "📦 Extracting Nmap..."
        tar xjf nmap-7.94.tar.bz2
        cd nmap-7.94

        echo "🔧 Configuring Nmap..."
        ./configure --prefix=/usr/local --without-zenmap
        
        echo "🏗️ Building Nmap..."
        make -j$(nproc)
        
        echo "📦 Installing Nmap..."
        sudo make install
        
        # Clean up
        cd ..
        rm -rf nmap-7.94 nmap-7.94.tar.bz2
        echo "✅ Nmap installed from source"
    else
        echo "❌ Nmap installation completely failed"
    fi
fi

echo "📋 Nmap status: $(nmap --version 2>/dev/null | head -1 || echo 'Not available')"
