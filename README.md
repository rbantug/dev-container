# Docker Dev Container 

## What?
A docker container that is isolated (to some extent) from the host machine. 
- It uses Squid Proxy that limits the dev container to communicate only with NPM and Github. So even if you get a compromised NPM package, it won't be able to send anything out of the container.
- On init, the user will run a bash script that will create a single SSH key. The user then adds the SSH public key to a single Github repo.
- It includes a .npmrc file that prevent NPM from installing the latest package and prevent scripts from running during installation.

## Why?
In order to prevent credentials from being stolen because of packages with malicious code. Supply chain attacks are becoming more frequent in the past few months.

## Why not use a VM?
A VM is a better solution for isolating your host machine. The problem is that several Linux VMs does not play nice with Windows Hyper-V. Thus, using a docker container is the next best solution.

## Prerequisites:
- Docker / Docker Desktop
- VSCode with the Dev Containers extension

## Setup
1. Clone this repo
2. In your project folder, run `docker compose -p <your preferred name> up -d` in your terminal. Docker will pull the image **ronbantug/dev-container** from Docker hub.
3. Run `docker exec -u root -it <name of dev container> chown -R node:node /workspace /home/node/.ssh` in a terminal. This will change the ownership of `/workspace` and `/home/node/.ssh` from **root** to **node**.
4. Run `docker exec -it <name of dev container> bash /home/node/add-ssh.sh` in a terminal. This will create the SSH key. The public SSH key will be printed at the end.
5. Add the SSH public key to Github. To add it to a single repo, go to the repo > Settings > Deploy Keys.
6. To establish a connection with your docker container to Github, run `docker exec -it <name of dev container> ssh -T git@github-project` in a terminal. Type "yes" in the first question and you should receive a reply that you've successfully authenticated.
7. In VSCode, press `Ctrl + Shift + P` and look for **Dev Containers: Attach to Running Container**. Select the dev container, not the squid container.
8. Once you're inside the container, go to `/workspace` and then clone your Github repo through SSH using this format: `git clone git@github-project:github-username/repo-name.git`
