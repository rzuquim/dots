function logs($subFolder, $file = '') {
  $logFolder = "$env:LOG_OUTPUT/$subFolder"
  if (-not (Test-Path $logFolder)) {
    throw "Could not find $logFolder"
  }

  if (-not $file) {
    $file = "*"
  }

  gci $logFolder -Filter "$file.log" | ForEach-Object {
    ii $_.FullName
  }
}
