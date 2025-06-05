FROM python:3.13-alpine@sha256:b4d299311845147e7e47c970566906caf8378a1f04e5d3de65b5f2e834f8e3bf

# Prepare Alpine for use
RUN mkdir -p /home/docker/github-backup/config;
ENV HOME /home/docker

# Copy files from git
COPY github-backup.py /home/docker/github-backup/github-backup.py
COPY pyproject.toml /home/docker/github-backup/pyproject.toml
COPY config.json.example /home/docker/github-backup/config.json.example
COPY backup.sh /home/docker/github-backup/backup.sh

# Install prerequisites
WORKDIR /home/docker/github-backup
RUN apk add --no-cache git tzdata; \
    python3 -m pip install --no-cache-dir uv; \
    uv sync --system -e .; \
    chmod -R 777 /home/docker; \
    chown -R 99:98 /home/docker; \
    chmod +x backup.sh;

# Use Unraid nobody user
USER 99:98

# Define default command.
CMD ["./backup.sh"]
