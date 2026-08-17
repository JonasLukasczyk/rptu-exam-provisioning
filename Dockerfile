FROM debian:13-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        xorriso \
        gettext-base \
    && curl -fsSL \
        https://enterprise.proxmox.com/debian/proxmox-release-trixie.gpg \
        -o /usr/share/keyrings/proxmox-release-trixie.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/proxmox-release-trixie.gpg] http://download.proxmox.com/debian/pve trixie pve-no-subscription" \
        > /etc/apt/sources.list.d/pve.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        proxmox-auto-install-assistant \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /project

CMD ["./build-iso.sh"]
