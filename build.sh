#!/bin/bash

# Build the penetration testing lab Docker image
echo "🚀 Building Stealth Penetration Testing Lab..."
echo "📦 This may take several minutes depending on your internet connection..."

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Build the image
if docker-compose build; then
    echo "✅ Build completed successfully!"
    echo ""
    echo "📋 Next steps:"
    echo "   To start the lab: ./start.sh"
    echo "   To access the lab: ./start.sh then docker exec -it stealth-pentest-lab bash"
    echo ""
    echo "🔧 Tools installed:"
    echo "   - Nmap (via apt)"
    echo "   - Nikto (via apt)"
    echo "   - Metasploit Framework (from source)"
    echo "   - Stealth configurations applied"
else
    echo "❌ Build failed! Trying with --no-cache..."
    docker-compose build --no-cache
fi
