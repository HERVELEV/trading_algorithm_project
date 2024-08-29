# Step 1: Download and install Minikube if not already installed
$minikubePath = "C:\minikube\minikube.exe"
if (-Not (Test-Path $minikubePath)) {
    Write-Output "Minikube not found. Downloading and installing Minikube..."
    New-Item -ItemType Directory -Force -Path "C:\minikube"
    Invoke-WebRequest -OutFile $minikubePath -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe' -UseBasicParsing
    Write-Output "Minikube installed successfully."
} else {
    Write-Output "Minikube already installed."
}

# Step 2: Add Minikube to PATH if not already added
$path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
if (-Not ($path -like "*C:\minikube*")) {
    Write-Output "Adding Minikube to system PATH..."
    [System.Environment]::SetEnvironmentVariable("Path", $path + ";C:\minikube", [System.EnvironmentVariableTarget]::Machine)
    Write-Output "Minikube added to PATH. Please restart your PowerShell session."
} else {
    Write-Output "Minikube is already in the system PATH."
}

# Step 3: Check Minikube version
Write-Output "Checking Minikube version..."
& "$minikubePath" version

# Step 4: Start Minikube
Write-Output "Starting Minikube..."
& "$minikubePath" start --driver=virtualbox

# Step 5: Verify Kubernetes Nodes
Write-Output "Verifying Kubernetes nodes..."
kubectl get nodes

# Step 6: Verify Kubernetes Services
Write-Output "Verifying Kubernetes services..."
kubectl get services

# Step 7: Launch Minikube Dashboard
Write-Output "Launching Minikube dashboard..."
& "$minikubePath" dashboard

Write-Output "Minikube setup and verification completed successfully."
