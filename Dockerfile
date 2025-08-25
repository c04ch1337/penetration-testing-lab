FROM debian:bookworm-slim

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Update package lists and install basic dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    git \
    build-essential \
    libreadline-dev \
    libssl-dev \
    libpcap-dev \
    zlib1g-dev \
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

# Install security tools separately
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nmap \
    nikto \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /opt

# Copy installation scripts
COPY scripts/ /tmp/scripts/

# Install tools
RUN chmod +x /tmp/scripts/*.sh && \
    /tmp/scripts/install_metasploit.sh

# Copy stealth configuration
COPY stealth-config/ /tmp/stealth-config/
RUN chmod +x /tmp/stealth-config/system-tweaks.sh && \
    /tmp/stealth-config/system-tweaks.sh

# Create non-root user
RUN useradd -m -s /bin/bash pentester && \
    echo "pentester:pentester" | chpasswd && \
    usermod -aG sudo pentester && \
    echo "pentester ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up working directories
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
