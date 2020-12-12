function confirm($path) {
    if (-not (Test-Path $path)) { return }
    $confirm = Read-Host -Prompt "There is already a $path available. Are you sure you want to overwrite it? (y/N)"
    if (-not $confirm.StartsWith('y') -and -not $confirm.StartsWith('Y')) {
        exit
    }
}

# ##############
# Git
# ##############

confirm("~/.gitconfig")
cp .\common\.gitconfig ~/.gitconfig -Force

# ##############
# Vim
# ##############

confirm("~/.ideavimrc")
cp .\common\.vimrc ~/.ideavimrc -Force
cp .\common\.vimrc ~/.vimrc -Force

# ##############
# Profile
# ##############

confirm($PROFILE)

$profileDir = Split-Path $PROFILE
cp .\windows_env\profile.ps1 $PROFILE -Force
rm $profileDir\profile -Recurse -Force
cp .\windows_env\profile $profileDir -Recurse -Force

& $profile
