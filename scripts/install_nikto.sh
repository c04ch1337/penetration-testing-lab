cat > scripts/install_nikto.sh << 'EOF'
#!/bin/bash

echo "📦 Installing Nikto..."

# Install additional Perl modules
sudo apt-get install -y libnet-ssleay-perl libwhisker2-perl

# Install latest Nikto from git
cd /opt
if [ ! -d "nikto" ]; then
    echo "🔍 Cloning Nikto repository..."
    git clone https://github.com/sullo/nikto.git
fi

cd nikto
echo "🔄 Updating Nikto..."
git pull

# Update Nikto database
echo "🔄 Updating Nikto database..."
perl nikto.pl -update

# Create symbolic link
sudo ln -sf /opt/nikto/program/nikto.pl /usr/local/bin/nikto

echo "✅ Nikto installed and updated successfully!"
echo "   Version: $(nikto -version 2>/dev/null | head -1 || echo 'Installed')"
EOF
