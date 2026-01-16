# install_aw_windows.ps1
# =======================
# Instala ActivityWatch v0.13.2, configura AFK + Window watchers
# Apunta a https://activitywatch.invmarg.com
# Autostart al login
# Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass
# .\install_aw_windows.ps1

# ===== CONFIG =====
$Version = "v0.13.2"
$Server = "https://activitywatch.invmarg.com"
$InstallDir = "$env:LOCALAPPDATA\ActivityWatch"
$ConfigDir = "$env:APPDATA\activitywatch"
$Hostname = $env:COMPUTERNAME

# ===== CREAR DIRECTORIOS =====
New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
New-Item -ItemType Directory -Force -Path $ConfigDir | Out-Null
Set-Location $InstallDir

# ===== DESCARGA =====
Invoke-WebRequest -Uri "https://github.com/ActivityWatch/activitywatch/releases/download/$Version/activitywatch-$Version-windows-x86_64.zip" -OutFile "aw.zip"
Expand-Archive -Force -LiteralPath "aw.zip"

# ===== CONFIG =====
@"
[sync]
server = "$Server"
hostname = "$Hostname"
"@ | Set-Content "$ConfigDir\aw-server.toml"

@"
timeout = 300
poll_time = 5
"@ | Set-Content "$ConfigDir\aw-watcher-afk.toml"

@"
poll_time = 5
exclude_title = true
"@ | Set-Content "$ConfigDir\aw-watcher-window.toml"

# ===== AUTOSTART =====
schtasks /create /sc onlogon /tn "ActivityWatchClient" `
/tr "cmd /c start /b $InstallDir\aw-server-rust\aw-server-rust.exe ^& $InstallDir\aw-watcher-afk\aw-watcher-afk.exe ^& $InstallDir\aw-watcher-window\aw-watcher-window.exe" `
/rl lowest /f

Write-Host "✅ ActivityWatch instalado y corriendo (Windows)"
