#!/bin/bash

ssh-keygen -t ed25519 -N "" -f ~/.ssh/github_repo_key -C "dev-container"

cat > ~/.ssh/config << 'EOF'
Host github-project
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_repo_key
    IdentitiesOnly yes
EOF

chmod 700 ~/.ssh
chmod 600 ~/.ssh/github_repo_key
chmod 644 ~/.ssh/github_repo_key.pub
chmod 600 ~/.ssh/config

echo public ssh key:
cat ~/.ssh/github_repo_key.pub