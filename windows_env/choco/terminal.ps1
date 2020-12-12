# terminal

cinst Jump-Location
cinst poshgit
cinst oh-my-posh

## Powerline
git clone https://github.com/powerline/fonts.git
pushd fonts
.\install.ps1
popd
rm .\fonts\ -Recurse -Force
