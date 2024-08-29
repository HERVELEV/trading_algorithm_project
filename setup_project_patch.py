import os

def create_file(file_path, content):
    if os.path.exists(file_path):
        print(f"File already exists: {file_path} (Skipping creation)")
    else:
        with open(file_path, 'w') as f:
            f.write(content)
        print(f"File created: {file_path}")

def setup_docker():
    # Créer un fichier Dockerfile
    dockerfile_content = """
    FROM python:3.9-slim

    WORKDIR /app

    COPY . .

    RUN pip install -r requirements.txt

    CMD ["python", "app.py"]
    """
    create_file('Dockerfile', dockerfile_content)

    # Mettre à jour le fichier docker-compose.yml
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

def setup_kubernetes():
    # Créer le fichier deployment.yaml
    deployment_yaml_content = """
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
    create_file('k8s/deployment.yaml', deployment_yaml_content)

    # Créer le fichier service.yaml
    service_yaml_content = """
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
    create_file('k8s/service.yaml', service_yaml_content)

    # Créer le fichier autoscaling.yaml
    autoscaling_yaml_content = """
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
    create_file('k8s/autoscaling.yaml', autoscaling_yaml_content)

def main():
    setup_docker()
    setup_kubernetes()
    print("Docker and Kubernetes setup completed successfully.")

if __name__ == "__main__":
    main()
