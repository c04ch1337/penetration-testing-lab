#!/bin/bash

# Nikto scanning examples for web application testing

echo "🎯 Nikto Web Scanning Examples"
echo "=============================="

TARGET=${1:-http://example.com}
OUTPUT_DIR=${2:-./reports}

echo "Target: $TARGET"
echo "Output: $OUTPUT_DIR"
echo ""

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# 1. Basic Nikto scan
echo "1. 🔍 Basic Nikto Scan:"
echo "   nikto -h $TARGET -o ${OUTPUT_DIR}/nikto_basic.txt"
echo ""

# 2. Comprehensive scan with all tests
echo "2. 📋 Comprehensive Scan:"
echo "   nikto -h $TARGET -C all -o ${OUTPUT_DIR}/nikto_comprehensive.html -F htm"
echo ""

# 3. Stealth scan with evasion
echo "3. 🕵️  Stealth Scan (Evasion Level 1):"
echo "   nikto -h $TARGET -evasion 1 -o ${OUTPUT_DIR}/nikto_stealth.txt"
echo ""

# 4. Scan with specific tuning
echo "4. 🎯 Targeted Scan (Tuning 9 - Extensive tests):"
echo "   nikto -h $TARGET -Tuning 9 -o ${OUTPUT_DIR}/nikto_targeted.html -F htm"
echo ""

# 5. Scan with authentication
echo "5. 🔐 Authenticated Scan:"
echo "   nikto -h $TARGET -id admin:password -o ${OUTPUT_DIR}/nikto_auth.txt"
echo ""

# 6. Scan with specific port
echo "6. 🚪 Specific Port Scan:"
echo "   nikto -h $TARGET -p 8080 -o ${OUTPUT_DIR}/nikto_port_8080.txt"
echo ""

# 7. Multiple targets from file
echo "7. 📄 Multiple Targets from File:"
echo "   nikto -h targets.txt -o ${OUTPUT_DIR}/nikto_multiple.html -F htm"
echo ""

echo "💡 Tips:"
echo "   - Use -update to update Nikto database before scanning"
echo "   - Combine with -v for verbose output"
echo "   - Use -maxtime to limit scan duration"
echo "   - Consider -nolookup to avoid DNS queries"
echo "   - Use -useragent to spoof user agent"
