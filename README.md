# DNS to DoT (DNS queries over TLS)
# Domain Name System (DNS) & Network Security

**DNS** stands for **Domain Name System** (often referred to as Domain Name Server), primarily serving as the central directory of the internet.

**TLS** is a security protocol that encrypts standard, plain-text Domain Name System queries using Transport Layer Security (TLS).

### Top Public DNS Servers
* **Cloudflare:** `1.1.1.1`
* **Google Public DNS:** `8.8.8.8`
* **Cisco OpenDNS:** `208.67.222.222`
  




## Pi-hole Implementation

Deploying a DNS server over a Pi-hole is an efficient and easy-to-maintain method for securing a privately hosted network. 

* **Default Resolver:** The Pi-hole serves as the primary DNS resolver by default.
* **Network Assignment:** The local router automatically assigns the Pi-hole as the DNS server whenever a new device attaches to the home network.

### Visual Architecture
See the detailed network resolution sequence here:  
👉 [Network Resolution Flow (GitHub)](https://github.com/deeprooter/piholeover-DoT/blob/main/DNSoverDoT.HTML)



## DNS over TLS (DoT)

Implementing **DNS over TLS (DoT)** completely wraps the raw requests your network sends to external servers inside an encrypted, secure network tunnel.

### Critical Reasons to Encrypt DNS Queries

* **Authenticates the Server:** DoT ensures you are communicating exclusively with your real, legitimate upstream DNS provider.
* **Prevents Tampering:** It blocks **Man-in-the-Middle (MitM) attacks**, where an outside hacker alters your request to secretly send your device to a fake website.
* **Stopping Network Disruption:** DNS servers are frequently targeted in **Distributed Denial of Service (DDoS) attacks** or exploited as "amplifiers" to crash other networks, which can take an entire organization or home completely offline.
* **Preventing Mass Redirection:** If a core DNS server is compromised, attackers can redirect thousands of users away from real websites (like banks or email providers) to identical phishing sites to steal credentials.
* **Protecting Data Privacy:** Unsecured DNS queries expose the exact browsing habits, active applications, and smart home device behaviors of every user on the network to outside observers.
* **Censorship & Manipulation:** External parties (such as your ISP) can alter unencrypted DNS results to block you from accessing certain services or force unwanted ads onto your browser.

DNS over TLS prevents ISP hijacking and DNS spoofing. Implementing DoT ensures that these internal routing requests remain encrypted and tamper-proof.


# Test Results 1 #
![terminal output](https://github.com/deeprooter/DNS-over-DoT/blob/main/test-results.png)
---
# Test Results 2 #
## 1.1.1.1/help ##
![terminal output](https://github.com/deeprooter/DNS-over-DoT/blob/main/DoT-enabled.png)

