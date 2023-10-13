#!/bin/bash

TARGET=${1:-$HOME}
pushd "$(dirname "${BASH_SOURCE}")" > /dev/null

function doIt() {
  rsync \
    --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude "bootstrap.sh" \
    --exclude ".editorconfig" \
    --exclude "README.md" \
    --exclude "TODO.md" \
    -avh --no-perms . $TARGET > /dev/null
}

echo "This may overwrite existing files in your home directory ($TARGET)."
read -p "Are you sure? (y/N) " -n 1
echo ""

# ==================
echo -n "🏠 Home ... "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  pushd ./common > /dev/null
  doIt
  popd > /dev/null

  DISTRO=$(hostnamectl | grep 'Operating System') > /dev/null

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
echo "✔️"

# ==================
echo -n "🔗 Symlinks ... "
# link to configuration files

if [ ! -L "$TARGET/.zshrc" ]; then
  ln -s $TARGET/.config/shell/zshrc $TARGET/.zshrc > /dev/null
fi
echo "✔️"

# ==================
echo -n "⚙️ Specific configs ... "

# .ideavim concat
cat ~/.vimrc ~/.ideavimrc > ~/.ideavimrc.tmp
mv ~/.ideavimrc.tmp ~/.ideavimrc

echo "✔️"

unset doIt
popd > /dev/null

