cat > scripts/install_nmap.sh << 'EOF'
#!/bin/bash

echo "📦 Installing Nmap..."

# Install latest Nmap from source
cd /tmp
echo "📥 Downloading latest Nmap..."
wget -q https://nmap.org/dist/nmap-7.94.tar.bz2

if [ $? -eq 0 ]; then
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
else
    echo "⚠️ Failed to download Nmap from source, using package manager version"
    sudo apt-get install -y nmap
fi

echo "✅ Nmap installed successfully!"
echo "   Version: $(nmap --version 2>/dev/null | head -1 || echo 'Installed')"
EOF
