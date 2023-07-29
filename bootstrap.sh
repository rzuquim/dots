#!/usr/bin/env bash

TARGET=${1:-$HOME}
pushd "$(dirname "${BASH_SOURCE}")" > /dev/null

function doIt() {
  rsync \
    --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude "bootstrap.sh" \
    --exclude "README.md" \
    -avh --no-perms . $TARGET > /dev/null
}
echo "This may overwrite existing files in your home directory ($TARGET)."
read -p "Are you sure? (y/N) " -n 1

# ==================
echo ""
echo -n "🏠 Home ... "
# ==================
if [[ $REPLY =~ ^[Yy]$ ]]; then
  pushd ./common > /dev/null
  doIt
  popd > /dev/null

  pushd ./linux/common > /dev/null
  doIt
  popd > /dev/null

  DISTRO=$(hostnamectl | grep 'Operating System')

  if [[ $DISTRO =~ .*"Arch".* ]]; then
    pushd ./linux/arch/home > /dev/null
    doIt
    popd > /dev/null
  elif [[ $DISTRO =~ "ubuntu" ]]; then
    pushd ./linux/ubuntu > /dev/null
    doIt
    popd > /dev/null
  fi
fi

# link to configuration files
ln -s $TARGET/config/shell/zshrc $TARGET/.zshrc

echo "✔️"

unset doIt
popd > /dev/null

