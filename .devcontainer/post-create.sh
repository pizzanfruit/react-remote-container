#!/bin/sh

if [ ! -d /local/ssh ]; then
    mkdir -p /local/ssh \
        && cp -r /root/.ssh-localhost/* /local/ssh \
        && chmod 700 /local/ssh \
        && chmod 600 /local/ssh/*
fi
cp -r /local/ssh ~/.ssh
chown root:root ~/.ssh -R

[ -d /local/ptools/.git ] || git clone <temporarily_redacted> /local/ptools;

bash /local/ptools/git/install-alias.sh
bash /local/ptools/bash/install-profile.sh

if [ -f /local/gitconfig ]; then
    cp /local/gitconfig ~/.gitconfig
else
    git config --global mergetool.vscode.cmd "code -w \$MERGED"
    git config --global difftool.vscode.cmd "code -w --diff \$LOCAL \$REMOTE"
    git config --global merge.tool vscode
    git config --global diff.tool vscode
    git config --global core.editor "code -w"
    git config --global user.name "$(sed -E 's/([a-z])([a-z]+)/\U\1\L\2/g;s/[.]/ /g;' <<< $1)"
    git config --global user.email $1@gmail.com
    cp ~/.gitconfig /local/gitconfig
fi

if [ -f package.json ] && [ -z "$(grep -e "/workspaces/*/node_modules" /etc/mtab)" ]; then
    mkdir -p /workspaces/node_modules/root;
    mount -o bind /workspaces/node_modules/root $PWD/node_modules
    # ln -s /workspaces/node_modules/root $PWD/node_modules
fi

NPM install
if [ -f package.json ]; then
	npm i && npm run build
fi

if [ -f lerna.json ]; then
	# disable ci on first bootstrap to prevent it trying to delete node_modules dirs
	npx lerna bootstrap --no-ci
	npx lerna bootstrap --hoist
	npx lerna link
fi
