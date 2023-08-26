
function bg-random {
  # Specify the path to the folder containing your background images
  $ImagePath = "$env:HOMEPATH\.dots\common\wallpapers"

  # Get all image files from the specified folder
  $ImageFiles = Get-ChildItem -Path $ImagePath -Filter "*.jpg" -File

  # If no images are found, exit the script
  if ($ImageFiles.Count -eq 0) {
      Write-Host "No image files found in the specified folder."
      exit
  }

  # Pick a random image from the array
  $RandomImage = (Get-Random -InputObject $ImageFiles).FullName

  # wallpaper
  $SetWallpaperSrc = @"
using System.Runtime.InteropServices;

public class Wallpaper {
  public const int SetDesktopWallpaper = 20;
  public const int UpdateIniFile = 0x01;
  public const int SendWinIniChange = 0x02;
  [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
  private static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
  public static void SetWallpaper(string path) {
    SystemParametersInfo(SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange);
  }
}
"@
  Add-Type -TypeDefinition $SetWallpaperSrc
  [Wallpaper]::SetWallpaper($RandomImage)

  # change lock screen
  $RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"

  if (!(Test-Path $RegKeyPath)) {
    New-Item -Path $RegKeyPath -Force | Out-Null
  }
  # Creating registry entries for Lock Screen
  $LockScreenStatus = "LockScreenImageStatus"
  $LockScreenPath = "LockScreenImagePath"
  $LockScreenUrl = "LockScreenImageUrl"
  $StatusValue = "1"

  New-ItemProperty -Path $RegKeyPath -Name $LockScreenStatus -Value $StatusValue -PropertyType DWORD -Force | Out-Null
  New-ItemProperty -Path $RegKeyPath -Name $LockScreenPath -Value $RandomImage -PropertyType STRING -Force | Out-Null
  New-ItemProperty -Path $RegKeyPath -Name $LockScreenUrl -Value $RandomImage -PropertyType STRING -Force | Out-Null
}

