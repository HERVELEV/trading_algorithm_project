# Vérifier si Minikube est déjà installé
if (Get-Command minikube -ErrorAction SilentlyContinue) {
    Write-Host "Minikube is already installed."
} else {
    # Installer Minikube
    Invoke-WebRequest -OutFile 'C:\minikube\minikube.exe' -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe' -UseBasicParsing
    Write-Host "Minikube installed."
}

# Ajouter Minikube au PATH
$minikubePath = "C:\minikube"
if ($env:Path -notlike "*$minikubePath*") {
    $env:Path += ";$minikubePath"
    [System.Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::User)
    Write-Host "Minikube added to PATH."
}

# Vérifier la version de Minikube
Write-Host "Checking Minikube version..."
minikube version

# Démarrer Minikube avec Docker
Write-Host "Starting Minikube with Docker driver..."
minikube start --driver=docker

# Vérifier les nœuds Kubernetes
Write-Host "Verifying Kubernetes nodes..."
kubectl get nodes

# Vérifier les services Kubernetes
Write-Host "Verifying Kubernetes services..."
kubectl get services

# Lancer le tableau de bord Minikube
Write-Host "Launching Minikube dashboard..."
minikube dashboard
