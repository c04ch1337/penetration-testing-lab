cat > update.sh << 'EOF'
#!/bin/bash

# Update all tools in the penetration testing lab
echo "🔄 Updating Stealth Penetration Testing Lab..."

# Check if container is running
if ! docker ps | grep -q "stealth-pentest-lab"; then
    echo "⚠️  Lab is not running. Starting it first..."
    ./start.sh
    sleep 5
fi

echo "📦 Updating all tools..."
docker exec -it stealth-pentest-lab bash -c "/tmp/scripts/update_tools.sh"

if [ $? -eq 0 ]; then
    echo "✅ Tools updated successfully!"
    echo ""
    echo "🔄 Restarting lab to apply updates..."
    ./stop.sh
    ./start.sh
else
    echo "❌ Tool update failed!"
    exit 1
fi
EOF
