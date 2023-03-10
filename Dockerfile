FROM nixos/nix

# The agent relies on bash for environment configuration
RUN ln -s $(which bash) /bin/bash

# Enable flakes
RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

# CodeBuild specific items
RUN nix-env -f '<nixpkgs>' -iA ssm-agent -A jq -A openssl -A cmake

# AWS SSM setup
COPY amazon-ssm-agent.json /tmp
RUN cp /tmp/amazon-ssm-agent.json $(nix show-derivation -f '<nixpkgs>' ssm-agent | jq -r '.[].outputs.out.path')/etc/amazon/ssm/amazon-ssm-agent.json

ENTRYPOINT ["ssm-agent-worker"]

