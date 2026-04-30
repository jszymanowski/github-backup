FROM python:3.14-alpine@sha256:dd4d2bd5b53d9b25a51da13addf2be586beebd5387e289e798e4083d94ca837a

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
