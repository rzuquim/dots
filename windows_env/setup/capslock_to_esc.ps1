
# To restore the keyboard, run regedit.exe and delete the "Scancode Map" entry from HKEY_CURRENT_USER (and log off/on), 
# or from HKEY_LOCAL_MACHINE (and reboot), depending on which section of the registry you changed.

Write-host "Biding your CASPLOCK key to ESC!"
ii .\capslock_to_esc.reg
