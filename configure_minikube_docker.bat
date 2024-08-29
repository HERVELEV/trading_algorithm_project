@echo off
echo Configuration de Minikube pour utiliser Docker comme driver...
minikube config set driver docker
if %errorlevel% neq 0 (
    echo Échec de la configuration du driver Docker pour Minikube.
    exit /b 1
)

echo Redémarrage de Minikube avec Docker comme driver...
minikube start --driver=docker
if %errorlevel% neq 0 (
    echo Échec du démarrage de Minikube avec Docker comme driver.
    exit /b 1
)

echo Vérification des nœuds Kubernetes...
kubectl get nodes
if %errorlevel% neq 0 (
    echo Les nœuds Kubernetes ne fonctionnent pas correctement.
    exit /b 1
)

echo Vérification des services Kubernetes...
kubectl get services
if %errorlevel% neq 0 (
    echo Les services Kubernetes ne fonctionnent pas correctement.
    exit /b 1
)

echo Lancement du tableau de bord Minikube...
start /wait minikube dashboard

echo Vérification terminée avec succès.
pause
