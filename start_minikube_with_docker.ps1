# Step 1: Check if Docker is installed
$dockerPath = "C:\Program Files\Docker\Docker\Docker Desktop.exe"
if (-Not (Test-Path $dockerPath)) {
    Write-Output "Docker Desktop is not installed. Please install Docker Desktop from https://www.docker.com/products/docker-desktop"
    exit 1
}

# Step 2: Start Docker Desktop if it's not running
$dockerProcess = Get-Process -Name "Docker Desktop" -ErrorAction SilentlyContinue
if (-Not $dockerProcess) {
    Write-Output "Starting Docker Desktop..."
    Start-Process $dockerPath
    Start-Sleep -Seconds 30  # Wait for Docker to start
} else {
    Write-Output "Docker Desktop is already running."
}

# Step 3: Start Minikube with Docker driver
Write-Output "Starting Minikube with Docker driver..."
minikube start --driver=docker

# Step 4: Verify Kubernetes Nodes
Write-Output "Verifying Kubernetes nodes..."
kubectl get nodes

# Step 5: Verify Kubernetes Services
Write-Output "Verifying Kubernetes services..."
kubectl get services

# Step 6: Launch Minikube Dashboard
Write-Output "Launching Minikube dashboard..."
minikube dashboard

Write-Output "Minikube setup with Docker completed successfully."
