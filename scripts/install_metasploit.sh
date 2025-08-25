cat > scripts/install_metasploit.sh << 'EOF'
#!/bin/bash

echo "📦 Installing Metasploit Framework..."

# Install Metasploit dependencies
sudo apt-get update && sudo apt-get install -y \
    autoconf \
    bison \
    bundler \
    libgmp-dev \
    libffi-dev \
    libyaml-dev

# Clone and install Metasploit
cd /opt
if [ ! -d "metasploit-framework" ]; then
    echo "🔍 Cloning Metasploit repository..."
    git clone https://github.com/rapid7/metasploit-framework.git
fi

cd metasploit-framework
echo "🔄 Updating Metasploit..."
git pull

# Install Ruby gems
echo "📦 Installing Ruby dependencies..."
bundle install

# Create symbolic links
echo "🔗 Creating symbolic links..."
for i in msf*; do
    sudo ln -sf /opt/metasploit-framework/$i /usr/local/bin/$i 2>/dev/null || true
done

# Initialize database
echo "💾 Initializing Metasploit database..."
sudo service postgresql start
msfdb init

echo "✅ Metasploit Framework installed successfully!"
echo "   Version: $(msfconsole --version 2>/dev/null | head -1 || echo 'Installed')"
EOF
