@echo off
echo Verification et correction de l'installation Docker et Minikube

:: Étape 1 : Vérification de Docker Desktop
echo Verification de l'etat de Docker Desktop...
IF EXIST "C:\Program Files\Docker\Docker\Docker Desktop.exe" (
    echo Docker Desktop est installe.
) ELSE (
    echo Docker Desktop n'est pas installe. Veuillez installer Docker Desktop avant de continuer.
    exit /b
)

:: Étape 2 : Redemarrage de Docker Desktop
echo Tentative de redemarrage de Docker Desktop...
taskkill /IM "Docker Desktop.exe" /F
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
timeout /t 20

:: Étape 3 : Verification de l'etat de Docker
docker version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Docker n'est pas encore operationnel. Veuillez verifier l'installation de Docker Desktop.
    exit /b
) ELSE (
    echo Docker est operationnel.
)

:: Étape 4 : Suppression de l'ancienne configuration Minikube
echo Suppression de l'ancienne configuration Minikube...
minikube delete

:: Étape 5 : Configuration de Minikube pour utiliser Docker
echo Configuration de Minikube pour utiliser Docker comme driver...
minikube start --driver=docker

IF %ERRORLEVEL% NEQ 0 (
    echo Echec de la configuration de Minikube avec Docker comme driver.
    exit /b
) ELSE (
    echo Minikube est configure pour utiliser Docker comme driver.
)

:: Étape 6 : Verification de Minikube et Kubernetes
echo Verification de Minikube et Kubernetes...
minikube status
kubectl get nodes
kubectl get services

echo Configuration terminee avec succes.
pause
