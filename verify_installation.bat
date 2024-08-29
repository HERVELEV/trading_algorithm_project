@echo off
echo Vérification de l'installation de Minikube...
minikube version
if %errorlevel% neq 0 (
    echo Minikube n'est pas installé ou n'est pas accessible depuis l'invite de commande.
    exit /b 1
)
echo Minikube est installé.

echo.
echo Vérification de l'installation de Docker...
docker --version
if %errorlevel% neq 0 (
    echo Docker n'est pas installé ou n'est pas accessible depuis l'invite de commande.
    exit /b 1
)
echo Docker est installé.

echo.
echo Vérification que Minikube utilise Docker comme driver...
minikube config get driver
if not "%errorlevel%"=="0" (
    echo Minikube ne semble pas utiliser Docker comme driver.
    exit /b 1
)

for /f "tokens=*" %%i in ('minikube config get driver') do set DRIVER=%%i
if not "%DRIVER%"=="docker" (
    echo Minikube est configuré pour utiliser %DRIVER% comme driver, et non Docker.
    exit /b 1
)
echo Minikube est configuré pour utiliser Docker comme driver.

echo.
echo Vérification des nœuds Kubernetes...
kubectl get nodes
if %errorlevel% neq 0 (
    echo Les nœuds Kubernetes ne fonctionnent pas correctement.
    exit /b 1
)
echo Les nœuds Kubernetes sont opérationnels.

echo.
echo Vérification des services Kubernetes...
kubectl get services
if %errorlevel% neq 0 (
    echo Les services Kubernetes ne fonctionnent pas correctement.
    exit /b 1
)
echo Les services Kubernetes sont opérationnels.

echo.
echo Lancement du tableau de bord Minikube...
start /wait minikube dashboard

echo.
echo Vérification terminée avec succès.
pause
