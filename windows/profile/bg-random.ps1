
function bg-random {
  # Specify the path to the folder containing your background images
  $ImagePath = "$env:HOME/.dotfiles/common/wallpapers"

# Get all image files from the specified folder
  $ImageFiles = Get-ChildItem -Path $ImagePath -Filter "*.jpg" -File

# If no images are found, exit the script
  if ($ImageFiles.Count -eq 0) {
      Write-Host "No image files found in the specified folder."
      exit
  }

# Pick a random image from the array
  $RandomImage = Get-Random -InputObject $ImageFiles

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

  [Wallpaper]::SetWallpaper($RandomImage.FullName)
}

