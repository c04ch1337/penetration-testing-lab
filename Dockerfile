FROM debian:bookworm-slim

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV STEALTH_MODE=true

# Update package lists and install basic dependencies with retry logic
RUN echo "🔄 Setting up Debian package sources..." && \
    apt-get update || apt-get update || apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    gnupg \
    lsb-release && \
    rm -rf /var/lib/apt/lists/*

# Add stable package sources
RUN echo "📦 Adding package repositories..." && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install basic tools and dependencies with retry mechanism
RUN echo "🚀 Installing core packages..." && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    wget \
    git \
    build-essential \
    libreadline-dev \
    libssl-dev \
    libpq-dev \
    libpcap-dev \
    zlib1g-dev \
    libsqlite3-dev \
    perl \
    ruby \
    ruby-dev \
    python3 \
    python3-pip \
    sudo \
    net-tools \
    iputils-ping \
    dnsutils \
    && rm -rf /var/lib/apt/lists/*

# Install specific tool versions separately with error handling
RUN echo "📦 Installing security tools..." && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    nmap \
    nikto \
    postgresql \
    postgresql-contrib \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /opt

# Copy installation scripts
COPY scripts/ /tmp/scripts/

# Install tools with error handling
RUN chmod +x /tmp/scripts/*.sh && \
    /tmp/scripts/install_metasploit.sh && \
    /tmp/scripts/install_nikto.sh && \
    /tmp/scripts/install_nmap.sh || echo "⚠️ Some tool installations may have warnings"

# Copy stealth configuration
COPY stealth-config/ /tmp/stealth-config/
RUN chmod +x /tmp/stealth-config/system-tweaks.sh && \
    /tmp/stealth-config/system-tweaks.sh

# Create non-root user for added stealth
RUN useradd -m -s /bin/bash pentester && \
    echo "pentester:pentester" | chpasswd && \
    usermod -aG sudo pentester && \
    echo "pentester ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up working directories with proper permissions
RUN mkdir -p /home/pentester/{tools,scans,reports} && \
    chown -R pentester:pentester /home/pentester && \
    chmod 755 /home/pentester

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    find /var/log -type f -exec truncate -s 0 {} \; 2>/dev/null || true

# Switch to non-root user
USER pentester
WORKDIR /home/pentester

# Set entrypoint
ENTRYPOINT ["/bin/bash"]
