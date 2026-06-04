FROM mcr.microsoft.com/devcontainers/javascript-node:1-22-bookworm

USER root

RUN apt-get update && \
    apt-get install -y openssh-client curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY .npmrc /etc/.npmrc
COPY --chown=node:node .npmrc /home/node/.npmrc
COPY --chown=node:node add-ssh.sh /home/node/add-ssh.sh

WORKDIR /workspace

USER node