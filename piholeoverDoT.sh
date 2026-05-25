#!/bin/bash

echo "Updating packages..."
sudo apt update
sudo apt install -y unbound dnsutils

# Define the file path
FILE_PATH="/etc/unbound/unbound.conf.d/pi-hole.conf"

echo "Creating Unbound configuration..."
# Write the service file
sudo tee "$FILE_PATH" > /dev/null << 'EOF'
server:
    # Explicitly define CA bundle path for Debian/Raspberry Pi OS
    tls-cert-bundle: "/etc/ssl/certs/ca-certificates.crt"
    
    access-control: 127.0.0.0/8 allow
    cache-max-ttl: 14400
    cache-min-ttl: 600
    do-tcp: yes
    hide-identity: yes
    hide-version: yes
    interface: 127.0.0.1
    minimal-responses: yes
    prefetch: yes
    qname-minimisation: yes
    rrset-roundrobin: yes
    ssl-upstream: yes
    use-caps-for-id: yes
    verbosity: 1
    port: 5533

forward-zone:
    name: "."
    forward-tls-upstream: yes
    # Quad9
    forward-addr: 9.9.9.9@853#dns.quad9.net
    forward-addr: 149.112.112.112@853#dns.quad9.net
    # Cloudflare
    forward-addr: 1.1.1.1@853#one.one.one.one
    forward-addr: 1.0.0.1@853#one.one.one.one
    # Google (Hostname required for cert validation)
    forward-addr: 8.8.8.8@853#dns.google
    forward-addr: 8.8.4.4@853#dns.google   
EOF

# Ensure correct ownership
sudo chown unbound:unbound "$FILE_PATH"

echo "Checking configuration syntax..."
if sudo unbound-checkconf; then
    echo "Configuration valid. Restarting Unbound..."
    sudo systemctl restart unbound
    sudo systemctl enable unbound
    echo "Unbound restarted successfully."
else
    echo "ERROR: Configuration check failed. Unbound NOT restarted."
    exit 1
fi

echo "Verifying Unbound is working..."
# Wait a moment for service to start
sleep 2
if dig @127.0.0.1 -p 5533 google.com +short; then
    echo "SUCCESS: DNS over TLS is working."
else
    echo "WARNING: Dig command failed. Check logs with 'sudo journalctl -u unbound'."
fi

echo "Done. Configure Pi-hole Custom DNS to: 127.0.0.1#5533"   

#127.0.0.1#5533
#sudo systemctl restart pihole-FTL

