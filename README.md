cat > README.md << 'EOF'
# 🕵️‍♂️ Stealth Penetration Testing Lab

![Docker](https://img.shields.io/badge/Docker-✓-blue)
![Metasploit](https://img.shields.io/badge/Metasploit-✓-red)
![Nmap](https://img.shields.io/badge/Nmap-✓-green)
![Nikto](https://img.shields.io/badge/Nikto-✓-orange)
![Stealth](https://img.shields.io/badge/Stealth-Enabled-black)
![License](https://img.shields.io/badge/License-MIT-yellow)

A Dockerized Debian-based penetration testing environment with Metasploit, Nmap, and Nikto, configured for stealth operations.

## 🎯 WHAT is this?

This repository contains a complete penetration testing laboratory environment that runs in Docker. It's designed for security professionals, ethical hackers, and cybersecurity students to practice and conduct security assessments in an isolated, controlled environment.

### Key Features:
- **🔒 Stealth Configuration**: Modified system fingerprints to avoid detection
- **📦 Latest Tools**: Always up-to-date security tools
- **🐳 Dockerized**: Easy to deploy and destroy
- **💾 Persistent Storage**: Data preservation between sessions
- **🌐 Network Access**: Full network capabilities for scanning
- **👤 Non-root User**: Enhanced security with dedicated user

## 🚀 HOW to Use

### Prerequisites
- Docker and Docker Compose installed
- Git installed
- Minimum 4GB RAM recommended
- Linux/macOS/WSL2 (Windows)

### Quick Start

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/penetration-testing-lab.git
   cd penetration-testing-lab
   ```
2. **Make scripts executable**:
```bash
chmod +x build.sh start.sh stop.sh update.sh
```
3. **Build the environment**:
```bash
./build.sh
```
4. **Start the lab**:
```bash
./start.sh
```
5. **Access the environment**:
```bash
    docker exec -it stealth-pentest-lab bash
```

### Manual Commands

# **Build**
```bash
docker-compose build
```
# **Start**
```bash
docker-compose up -d
```
# **Stop**
```bash
docker-compose down
```
# **Access**
```bash
docker exec -it stealth-pentest-lab bash
```

## 🛠️ Tools Overview
🔍 **Nmap (Network Mapper)**

**WHAT**: Network discovery and security auditing tool
**WHY**: Essential for network reconnaissance and vulnerability assessment

Examples:
bash

# Basic stealth scan
nmap -sS -T2 target.com

# Version detection
nmap -sS -sV -T2 target.com

# OS detection with evasion
nmap -sS -O -T2 --osscan-limit target.com

⚔️ Metasploit Framework

WHAT: Penetration testing platform for developing and executing exploits
WHY: Industry-standard tool for exploitation and post-exploitation

Examples:
bash

# Start Metasploit
msfconsole

# Search for exploits
search type:exploit platform:windows

# Use an exploit
use exploit/windows/smb/ms17_010_eternalblue
set RHOSTS target.com
exploit

🕵️‍♂️ Nikto Web Scanner

WHAT: Web server vulnerability scanner
WHY: Comprehensive web application security assessment

Examples:
bash

# Basic scan
nikto -h https://target.com

# Stealth scan
nikto -h target.com -evasion 1

# Save results
nikto -h target.com -o results.html -F htm

🎯 Use Cases
1. Network Security Assessment
bash

# Comprehensive network scan
nmap -sS -sV -sC -O -T2 target-network/24

# Metasploit auxiliary modules
use auxiliary/scanner/portscan/tcp
set RHOSTS target-network/24
run

2. Web Application Testing
bash

# Nikto web scan
nikto -h https://webapp.com -C all -Tuning 9

# Metasploit web modules
use auxiliary/scanner/http/http_version
set RHOSTS webapp.com
run

3. Stealth Operations
bash

# Slow, stealthy scan
nmap -sS -T1 --max-parallelism 1 --scan-delay 5s target.com

# Metasploit with evasion
use auxiliary/scanner/portscan/tcp
set RHOSTS target.com
set DELAY 10000
set JITTER 5000
run

🔧 Configuration Details
Stealth Features

    Modified Hostname: Generic hostname to avoid detection

    Cleaned System Logs: Regular log cleaning

    Docker Metadata Removal: Hides containerization artifacts

    Custom User Agent: Modified package manager fingerprints

    OS Spoofing: Appears as Ubuntu server to scanners

Security Features

    Non-root User: Operations as dedicated pentester user

    Limited Privileges: Minimal required capabilities

    Log Cleaning: Automatic log maintenance

    Network Isolation: Controlled network access

📁 Directory Structure
text

penetration-testing-lab/
├── Dockerfile              # Main Docker configuration
├── docker-compose.yml      # Container orchestration
├── build.sh               # Build script
├── start.sh              # Start script
├── stop.sh               # Stop script
├── update.sh             # Update tools script
├── scripts/              # Installation scripts
├── stealth-config/       # Stealth configuration files
├── examples/            # Usage examples
├── data/                # Persistent data (created)
├── logs/                # Application logs (created)
└── reports/             # Scan reports (created)

⚠️ Legal and Ethical Considerations

IMPORTANT: This tool is intended for:

    ✅ Educational purposes

    ✅ Authorized penetration testing

    ✅ Security research

    ✅ Ethical hacking practice

DO NOT USE for:

    ❌ Unauthorized testing

    ❌ Illegal activities

    ❌ Malicious purposes

Always obtain proper authorization before testing any system.
🔄 Maintenance
Updating Tools
bash

# Run update script
./update.sh

# Or manually inside container
docker exec stealth-pentest-lab /tmp/scripts/update_tools.sh

Backup Data
bash

# Backup important data
tar -czf backup-$(date +%Y%m%d).tar.gz data/ logs/ reports/

🤝 Contributing

    Fork the repository

    Create a feature branch

    Make your changes

    Test thoroughly

    Submit a pull request

📝 License

MIT License - see LICENSE file for details.
🆘 Support

For issues and questions:

    Check existing GitHub issues

    Create a new issue with detailed information

    Provide logs and reproduction steps

Happy (ethical) hacking! 🎯

Remember: With great power comes great responsibility. Always test ethically and with proper authorization.
EOF
