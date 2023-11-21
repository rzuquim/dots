
function work() {
  if ($args.Count -eq 0) {
    $query = ""
  } else {
    $query = "-q $args"
  }

  fd `
    --type directory `
    --unrestricted `
    --max-depth 5 `
    --exclude .cache --exclude .asdf --exclude .local --exclude .cargo --exclude node-modules `
    --exclude bin --exclude obj `
    --prune ^.git$ D:\dev | `
  split-path -Parent | Select-Object { "[" + [System.IO.Path]::GetFileName($_) + "] " + $_ } | `
  Format-Table -HideTableHeaders ` |
  fzf -1 $query | `
  awk '{ print $2 }' |
  Set-Location
}

function inoa {
  & D:\dev\ops\cli\src\bin\Debug\net6.0\Inoa.Cli.exe $args
}

