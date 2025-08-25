#!/bin/bash

echo "📦 Installing Metasploit Framework..."

# Install Metasploit dependencies
sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    autoconf \
    bison \
    bundler \
    libgmp-dev \
    libffi-dev \
    libyaml-dev

# Clone Metasploit
cd /opt
if [ ! -d "metasploit-framework" ]; then
    echo "🔍 Cloning Metasploit repository..."
    git clone https://github.com/rapid7/metasploit-framework.git --depth 1
fi

cd metasploit-framework

# Install Ruby gems
echo "📦 Installing Ruby dependencies..."
bundle install

# Create symbolic links
echo "🔗 Creating symbolic links..."
for i in msf*; do
    sudo ln -sf /opt/metasploit-framework/$i /usr/local/bin/$i 2>/dev/null || true
done

echo "✅ Metasploit Framework installed!"
