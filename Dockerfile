FROM ubuntu:latest
WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    unzip \
    libicu-dev

# Copy Tailscale binaries
COPY --from=docker.io/tailscale/tailscale:stable /usr/local/bin/tailscaled /app/tailscaled
COPY --from=docker.io/tailscale/tailscale:stable /usr/local/bin/tailscale /app/tailscale

# Create necessary directories for Tailscale
RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

# Copy start script & chmod
COPY start.sh /app/start.sh
COPY server.js /app/server.js
RUN chmod +x /app/start.sh
RUN curl -fsSL https://bun.sh/install | bash
RUN . ~/.bashrc

# Set up environment
ARG PORT
EXPOSE ${PORT:-8000}

# Set entrypoint
CMD ["/bin/sh", "-c", "~/.bun/bin/bun /app/server.js & /app/start.sh"]