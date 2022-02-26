$env:HOST_IP = (Test-Connection -ComputerName (hostname) -Count 1).IPV4Address.IPAddressToString;

Set-Alias -Name opencover -Value OpenCover.Console.exe
