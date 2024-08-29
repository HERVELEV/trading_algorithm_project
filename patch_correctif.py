import os

def create_file(file_path, content):
    """Create a file with the given content."""
    with open(file_path, 'w') as f:
        f.write(content)
    print(f"File created or updated: {file_path}")

def create_requirements_file():
    """Create a requirements.txt file."""
    requirements = """
Flask==2.1.1
requests==2.26.0
pandas==1.3.3
numpy==1.21.2
scikit-learn==0.24.2
"""
    create_file('requirements.txt', requirements)

def create_dockerfile():
    """Create or update the Dockerfile."""
    dockerfile_content = """
# Dockerfile
FROM python:3.9-slim

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "app.py"]
"""
    create_file('Dockerfile', dockerfile_content)

def create_docker_compose():
    """Create or update the docker-compose.yml file."""
    docker_compose_content = """
version: "3.8"
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "8000:8000"
    volumes:
      - .:/app
"""
    create_file('docker-compose.yml', docker_compose_content)

def create_kubernetes_files():
    """Create or update the Kubernetes configuration files."""
    deployment_yaml = """
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-container
        image: my-image:latest
        ports:
        - containerPort: 80
"""
    service_yaml = """
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer
"""
    autoscaling_yaml = """
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: my-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: my-app
  minReplicas: 1
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
"""
    create_file('k8s/deployment.yaml', deployment_yaml)
    create_file('k8s/service.yaml', service_yaml)
    create_file('k8s/autoscaling.yaml', autoscaling_yaml)

def main():
    create_requirements_file()
    create_dockerfile()
    create_docker_compose()
    create_kubernetes_files()
    print("Patch applied successfully. Please rebuild your Docker images and redeploy your Kubernetes resources.")

if __name__ == "__main__":
    main()
