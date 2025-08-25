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
