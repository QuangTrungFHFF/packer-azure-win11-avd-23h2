Write-Host "▶ Script started: install-language-pack.ps1"

# initial wait time for Windows Update.
Write-Host "▶ Initial sleep to let system services settle (e.g., Windows Update)..."
Start-Sleep -Seconds 60 

# Attempt to stop services that commonly interfere with DISM
Write-Host "▶ Attempting to stop Windows Update service (wuauserv)..."
Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
$wuauservStatus = Get-Service wuauserv
Write-Host "   wuauserv status after stop attempt: $($wuauservStatus.Status)"

#Stop TrustedInstaller service if it is running
Write-Host "▶ Attempting to stop Windows Modules Installer service (TrustedInstaller)..."
Stop-Service TrustedInstaller -Force -ErrorAction SilentlyContinue
$trustedInstallerStatus = Get-Service TrustedInstaller
Write-Host "   TrustedInstaller status after stop attempt: $($trustedInstallerStatus.Status)"

Write-Host "▶ Sleeping briefly after attempting to stop services..."
Start-Sleep -Seconds 15

#########################################################
Write-Host "▶ Installing language pack and UI settings..."

# Install language capabilities via DISM
dism /online /add-capability /capabilityname:Language.Basic~~~de-DE~0.0.1.0 /quiet /norestart

# Optional components:
 dism /online /add-capability /capabilityname:Language.Speech~~~de-DE~0.0.1.0 /quiet /norestart
 dism /online /add-capability /capabilityname:Language.TextToSpeech~~~de-DE~0.0.1.0 /quiet /norestart
 dism /online /add-capability /capabilityname:Language.Handwriting~~~de-DE~0.0.1.0 /quiet /norestart
Write-Host "▶ DISM command(s) issued. Waiting for changes to register before restart..."

Write-Host "▶ Sleep..."
Start-Sleep -Seconds 60
Write-Host "▶ Language pack script completd. System will now be restarted by Packer."
