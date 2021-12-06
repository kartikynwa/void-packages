#!/usr/bin/env sh

set -e

echo "Rebasing branch on upstream master"
git fetch upstream
git rebase upstream/master

version="0.7.0+$(date +%Y%m%d)"
template='./srcpkgs/neovim/template'
echo "Updating neovim version variable to $version"
sed -i "s/^version=.*/version=${version}/" srcpkgs/neovim/template
xgensum -i srcpkgs/neovim/template
./xbps-src pkg neovim
git reset HEAD^
xbump neovim
