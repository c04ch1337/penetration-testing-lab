#!/bin/bash

# Stop the penetration testing lab
echo "🛑 Stopping Stealth Penetration Testing Lab..."

docker-compose down

if [ $? -eq 0 ]; then
    echo "✅ Lab stopped successfully!"
    echo "All containers and networks have been removed."
else
    echo "⚠️  Lab may not have been running, or there was an issue stopping it."
fi
