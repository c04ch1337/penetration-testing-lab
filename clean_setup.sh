#!/bin/bash

# Clean setup script for penetration testing lab
echo "🧹 Cleaning up previous builds..."
docker-compose down 2>/dev/null
docker rmi penetration-testing-lab_pentest-lab 2>/dev/null
docker system prune -f

echo "📦 Creating minimal file structure..."
mkdir -p scripts stealth-config examples

# Create minimal Dockerfile
cat > Dockerfile << 'DOCKERFILE'
FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl wget git nmap nikto perl ruby python3 sudo net-tools && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
COPY scripts/ /tmp/scripts/
RUN chmod +x /tmp/scripts/*.sh

RUN useradd -m -s /bin/bash pentester && \
    echo "pentester ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER pentester
WORKDIR /home/pentester
ENTRYPOINT ["/bin/bash"]
DOCKERFILE

# Create minimal docker-compose.yml
cat > docker-compose.yml << 'COMPOSE'
version: '3.8'
services:
  pentest-lab:
    build: .
    container_name: stealth-pentest-lab
    hostname: generic-server
    network_mode: bridge
    volumes:
      - ./data:/home/pentester/data
    ports:
      - "4444:4444"
    stdin_open: true
    tty: true
COMPOSE

# Create minimal metasploit installer
mkdir -p scripts
cat > scripts/install_metasploit.sh << 'METASPLOIT'
#!/bin/bash
echo "Installing Metasploit..."
sudo apt-get update && sudo apt-get install -y bundler libgmp-dev
cd /opt
git clone https://github.com/rapid7/metasploit-framework.git --depth 1
cd metasploit-framework
bundle install
for i in msf*; do sudo ln -sf /opt/metasploit-framework/$i /usr/local/bin/$i 2>/dev/null || true; done
METASPLOIT

chmod +x scripts/install_metasploit.sh

echo "✅ Minimal setup created! Run ./build.sh to build the environment."

chmod +x clean_setup.sh
