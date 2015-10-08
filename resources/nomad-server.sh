#!/bin/sh

set -eu

mkdir -p /etc/nomad/db

cat <<EOF > /etc/nomad/nomad.hcl
# Increase log verbosity
log_level = "INFO"

# Setup data dir
data_dir = "/etc/nomad/db"

# Enable the server
server {
    enabled = true

    # Self-elect, should be 3 or 5 for production
    bootstrap_expect = 3
}
EOF

nohup /usr/local/bin/nomad -config=/etc/nomad/nomad.hcl &

exit 0
