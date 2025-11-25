<#
PowerShell script: install_git_to_d_qpp.ps1
Purpose: Download Git for Windows installer and install silently to specified directory (default D:\qpp\Git).
Usage (run PowerShell as Administrator):
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
    .\install_git_to_d_qpp.ps1

Note: Installer from Git for Windows official releases/latest download link. Script downloads latest 64-bit package and installs with /VERYSILENT mode.
To modify target directory, pass parameter:
    .\install_git_to_d_qpp.ps1 -InstallDir 'D:\qpp\MyGit'
#>

param(
    [string]$InstallDir = 'D:\qpp\Git',
    [string]$InstallerPath = 'D:\qpp\Git-64-bit.exe',
    # Use mirror or specific version if GitHub is unstable
    [string]$DownloadUrl = 'https://registry.npmmirror.com/-/binary/git-for-windows/v2.47.1.windows.1/Git-2.47.1-64-bit.exe'
)

function Ensure-Admin {
    $cur = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($cur)
    if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Error "Please re-run this script as Administrator (Right-click PowerShell -> Run as Administrator)."
        exit 1
    }
}

Ensure-Admin

# Create download directory
$installerDir = Split-Path -Path $InstallerPath -Parent
if (-not (Test-Path -Path $installerDir)) {
    New-Item -Path $installerDir -ItemType Directory -Force | Out-Null
}

Write-Output "Starting download Git installer to: $InstallerPath"
Write-Output "Download URL: $DownloadUrl"

# Add retry logic and use TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$maxRetries = 3
$retryCount = 0
$downloaded = $false

while (-not $downloaded -and $retryCount -lt $maxRetries) {
    try {
        $retryCount++
        Write-Output "Attempt $retryCount of $maxRetries..."
        Invoke-WebRequest -Uri $DownloadUrl -OutFile $InstallerPath -UseBasicParsing -TimeoutSec 300 -ErrorAction Stop
        $downloaded = $true
        Write-Output "Download completed successfully!"
    } catch {
        Write-Warning "Download attempt $retryCount failed: $($_.Exception.Message)"
        if ($retryCount -lt $maxRetries) {
            Write-Output "Retrying in 5 seconds..."
            Start-Sleep -Seconds 5
        } else {
            Write-Error "Download failed after $maxRetries attempts. Please check your network connection or try downloading manually from: $DownloadUrl"
            exit 1
        }
    }
}

Write-Output "Download completed, file size: $((Get-Item $InstallerPath).Length) bytes"

# Run installer (silent)
$argList = @('/VERYSILENT', '/NORESTART', "/DIR=$InstallDir")
Write-Output "Starting silent installation to: $InstallDir"
$proc = Start-Process -FilePath $InstallerPath -ArgumentList $argList -Wait -PassThru
if ($proc.ExitCode -ne 0) {
    Write-Warning "Installer returned non-zero exit code: $($proc.ExitCode) (sometimes installer returns non-zero but may still succeed, please check git version below)."
}

# Check if git is available
$gitExe = Join-Path $InstallDir 'cmd\git.exe'
if (Test-Path $gitExe) {
    & $gitExe --version
} else {
    Write-Warning "Git not found at expected location, try manually checking install directory: $InstallDir"
}

Write-Output "Installation completed. To add Git to system PATH, follow README instructions (this step may require restart or Administrator privileges to modify environment variables)."

# Optional: Automatically add Git cmd path to machine PATH (commented out, enable if needed)
<#
$gitCmdPath = Join-Path $InstallDir 'cmd'
$gitBinPath = Join-Path $InstallDir 'mingw64\bin'
$gitUsrBin = Join-Path $InstallDir 'usr\bin'
$machinePath = [Environment]::GetEnvironmentVariable('Path',[EnvironmentVariableTarget]::Machine)
if ($machinePath -notlike "*$gitCmdPath*") {
    $newPath = $machinePath + ";" + $gitCmdPath + ";" + $gitBinPath + ";" + $gitUsrBin
    [Environment]::SetEnvironmentVariable('Path', $newPath, [EnvironmentVariableTarget]::Machine)
    Write-Output "Updated machine-level PATH (may require logout/restart to take effect)."
} else {
    Write-Output "PATH already contains Git path."
}
#>

Write-Output "Script finished."