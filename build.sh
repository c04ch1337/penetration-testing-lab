#!/bin/bash

# Build the penetration testing lab Docker image
echo "🚀 Building Stealth Penetration Testing Lab..."
echo "📦 This may take several minutes depending on your internet connection..."

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Clean up any previous builds
echo "🧹 Cleaning up previous builds..."
docker-compose down 2>/dev/null
docker rmi penetration-testing-lab_pentest-lab 2>/dev/null

# Build with retry logic
for attempt in {1..3}; do
    echo "🔨 Build attempt $attempt..."
    if docker-compose build; then
        echo "✅ Build completed successfully!"
        echo ""
        echo "📋 Next steps:"
        echo "   To start the lab: ./start.sh"
        echo "   To access the lab: ./start.sh then docker exec -it stealth-pentest-lab bash"
        echo ""
        echo "🔧 Tools installed:"
        echo "   - Metasploit Framework"
        echo "   - Nmap"
        echo "   - Nikto"
        echo "   - Stealth configurations"
        exit 0
    else
        echo "⚠️ Build attempt $attempt failed, retrying in 5 seconds..."
        sleep 5
    fi
done

echo "❌ Build failed after 3 attempts! Common issues:"
echo "   - Network connectivity problems"
echo "   - Docker not running with proper permissions"
echo "   - Out of disk space"
echo "   - Check 'docker system df' and 'docker system prune' if needed"
exit 1
