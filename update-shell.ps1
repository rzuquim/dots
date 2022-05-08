function confirm($path) {
    if (-not (Test-Path $path)) { return $true }
    $confirm = Read-Host -Prompt "There is already a $path available. Are you sure you want to overwrite it? (y/N)"
    return $confirm.StartsWith('y') -or $confirm.StartsWith('Y')
}

# ##############
# Git
# ##############

if (confirm("~/.gitconfig")) {
  cp .\common\.gitconfig ~/.gitconfig -Force
}

# ##############
# Vim
# ##############

if (confirm("~/.ideavimrc")) {
  cp .\common\.vimrc ~/.ideavimrc -Force
  cp .\common\.vimrc ~/.vimrc -Force
}

# ##############
# Prompt
# ##############
if (confirm("~/.rzuquim.omp.json")) {
  cp .\common\.rzuquim.omp.json ~/.rzuquim.omp.json -Force
}

# ##############
# Profile
# ##############

if (confirm($PROFILE)) {
  $profileDir = Split-Path $PROFILE
  cp .\windows\profile.ps1 $PROFILE -Force
  rm $profileDir\profile -Recurse -Force
  cp .\windows\profile $profileDir -Recurse -Force
}

& $profile
