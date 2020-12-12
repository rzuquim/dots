function grep($search) { 
    Select-String -Pattern $search
}

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
