cat > examples/nmap_scan.sh << 'EOF'
#!/bin/bash

# Nmap scanning examples for stealth operations

echo "🎯 Nmap Stealth Scanning Examples"
echo "================================="

TARGET=${1:-example.com}

echo "Target: $TARGET"
echo ""

# 1. Basic stealth scan
echo "1. 🔍 Basic Stealth Scan (SYN Scan):"
echo "   nmap -sS -T2 $TARGET"
echo ""

# 2. Version detection with timing control
echo "2. 📋 Version Detection (Stealth Mode):"
echo "   nmap -sS -sV -T2 --version-intensity 5 $TARGET"
echo ""

# 3. OS detection with evasion
echo "3. 🖥️  OS Detection (Evasion Techniques):"
echo "   nmap -sS -O -T2 --osscan-limit --fuzzy $TARGET"
echo ""

# 4. Full stealth comprehensive scan
echo "4. 🕵️  Full Stealth Comprehensive Scan:"
echo "   nmap -sS -sV -sC -O -T2 --script-timeout 30s --max-retries 2 $TARGET"
echo ""

# 5. Firewall evasion techniques
echo "5. 🛡️  Firewall Evasion Techniques:"
echo "   nmap -sS -T2 -D RND:10 --source-port 53 --data-length 24 $TARGET"
echo ""

# 6. Slow scan to avoid detection
echo "6. 🐌 Slow Scan (Avoid IDS Detection):"
echo "   nmap -sS -T1 --max-parallelism 1 --scan-delay 5s $TARGET"
echo ""

# 7. Fragment packets for evasion
echo "7. 🧩 Packet Fragmentation:"
echo "   nmap -sS -f --mtu 24 $TARGET"
echo ""

echo "💡 Tips:"
echo "   - Use -T timing template (0-5, where 0 is slowest/stealthiest)"
echo "   - Combine with --scan-delay for additional stealth"
echo "   - Use -D for decoy IP addresses"
echo "   - Consider --spoof-mac for MAC address spoofing"
echo "   - Always test evasion techniques in lab environment first"
EOF
