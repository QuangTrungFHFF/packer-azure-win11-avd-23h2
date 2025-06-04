Write-Host "▶ Installing language pack and UI settings..."

# Install language capabilities via DISM
dism /online /add-capability /capabilityname:Language.Basic~~~de-DE~0.0.1.0 /quiet /norestart

# Optional additional components:
# dism /online /add-capability /capabilityname:Language.Speech~~~de-DE~0.0.1.0 /quiet /norestart
# dism /online /add-capability /capabilityname:Language.TextToSpeech~~~de-DE~0.0.1.0 /quiet /norestart
# dism /online /add-capability /capabilityname:Language.Handwriting~~~de-DE~0.0.1.0 /quiet /norestart

Write-Host "▶ Sleep..."
# Wait briefly for changes to register
Start-Sleep -Seconds 15
