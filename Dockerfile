FROM alpine:3.19

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
RUN apk add --no-cache python3 git tzdata; \
    python3 -m pip install --no-cache-dir uv; \
    uv pip install --system --no-cache -e .; \
    chmod -R 777 /home/docker; \
    chown -R 99:98 /home/docker; \
    chmod +x backup.sh;

# Use Unraid nobody user
USER 99:98

# Define default command.
CMD ["./backup.sh"]
