
function work() {
  fd `
    --type directory `
    --unrestricted `
    --max-depth 3 `
    --exclude .cache --exclude .asdf --exclude .local --exclude .cargo --exclude node-modules `
    --exclude bin --exclude obj `
    --prune ^.git$ D:\dev | `
  split-path -Parent | Select-Object { "[" + [System.IO.Path]::GetFileName($_) + "] " + $_ } | `
  Format-Table -HideTableHeaders ` |
  fzf | `
  awk '{ print $2 }' |
  Set-Location
}
