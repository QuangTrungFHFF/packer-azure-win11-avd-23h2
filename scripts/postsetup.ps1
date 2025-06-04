Write-Host "▶ Setting timezone..."
# Configure user interface
Set-TimeZone -Id "W. Europe Standard Time"
Set-SystemPreferredUILanguage "de-DE"
Set-WinSystemLocale "de-DE"
Set-WinUserLanguageList "de-DE" -Force
Set-WinHomeLocation -GeoId "94"
Set-Culture "de-DE"

Write-Host "▶ Installing Notepad..."
# Install Notepad
Add-WindowsCapability -Online -Name "Microsoft.Windows.Notepad~~~~0.0.1.0" -ErrorAction Stop