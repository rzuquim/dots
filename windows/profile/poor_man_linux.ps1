Set-Alias -Name grep -Value rg -Option AllScope
Set-Alias -Name cat -Value bat -Option AllScope

function wc {
    param(
        [Parameter(ValueFromPipeline=$true)] $txt,
        [switch] $l,
        [switch] $m,
        [switch] $w
    )

    if ($l) { return Measure-Object -InputObject $txt -Line | Select-Object -ExpandProperty Lines }
    if ($m) { return Measure-Object -InputObject $txt -Character | Select-Object -ExpandProperty Characters }
    else { return Measure-Object -InputObject $txt -Word | Select-Object -ExpandProperty Words }
}

function unixtimestamp() {
    [int][double]::parse((get-date -UFormat %s))
}

function head {
  param(
      [Parameter(ValueFromPipeline=$true)] $file,
      $size
  )
  if (-not $size) { $size = 1024 }
  $bytes = Get-Content $file -Encoding byte -TotalCount $size
  [System.Text.Encoding]::UTF8.GetString($bytes)
}
