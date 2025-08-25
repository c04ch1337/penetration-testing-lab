cat > start.sh << 'EOF'
#!/bin/bash

# Start the penetration testing lab
echo "🔧 Starting Stealth Penetration Testing Lab..."

# Check if container is already running
if docker ps | grep -q "stealth-pentest-lab"; then
    echo "⚠️  Lab is already running!"
    echo "To access: docker exec -it stealth-pentest-lab bash"
    exit 0
fi

# Start the container
docker-compose up -d

if [ $? -eq 0 ]; then
    echo "✅ Lab started successfully!"
    echo ""
    echo "🎯 Access methods:"
    echo "   docker exec -it stealth-pentest-lab bash"
    echo "   docker logs stealth-pentest-lab"
    echo ""
    echo "📁 Directories:"
    echo "   ./data/    - Persistent data storage"
    echo "   ./logs/    - Application logs"
    echo "   ./reports/ - Scan reports and output"
    echo ""
    echo "⏹️  To stop the lab: ./stop.sh"
else
    echo "❌ Failed to start lab!"
    exit 1
fi
EOF
