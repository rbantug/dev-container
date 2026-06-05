#!/bin/bash

ssh-keygen -t ed25519 -N "" -f ~/.ssh/github_repo_key -C "dev-container"

cat > ~/.ssh/config << 'EOF'
Host github-project
    HostName ssh.github.com
    Port 443
    User git

    IdentityFile ~/.ssh/github_repo_key
    IdentitiesOnly yes

    ProxyCommand nc -X connect -x squid:3128 %h %p
EOF

chmod 700 ~/.ssh
chmod 600 ~/.ssh/github_repo_key
chmod 644 ~/.ssh/github_repo_key.pub
chmod 600 ~/.ssh/config

echo public ssh key:
cat ~/.ssh/github_repo_key.pub