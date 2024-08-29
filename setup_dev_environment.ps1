# Vérifier si Visual Studio Code est installé
$vsCodePath = "C:\Program Files\Microsoft VS Code\Code.exe"
if (-Not (Test-Path $vsCodePath)) {
    Write-Host "Visual Studio Code n'est pas installé. Installation en cours..."

    # Télécharger l'installateur de Visual Studio Code
    $installerUrl = "https://update.code.visualstudio.com/latest/win32-x64/stable"
    $installerPath = "$env:TEMP\VSCodeSetup.exe"
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

    # Exécuter l'installateur en mode silencieux
    Start-Process -FilePath $installerPath -ArgumentList "/verysilent" -NoNewWindow -Wait
} else {
    Write-Host "Visual Studio Code est déjà installé."
}

# Définir le chemin de l'exécutable `code`
$codeCmd = "$vsCodePath --install-extension"

# Installer les extensions Visual Studio Code
Write-Host "Installation des extensions Visual Studio Code..."
& $codeCmd "ms-python.python"
& $codeCmd "ms-azuretools.vscode-docker"
& $codeCmd "eamodio.gitlens"
& $codeCmd "esbenp.prettier-vscode"

Write-Host "Configuration de l'environnement de développement terminée avec succès."
