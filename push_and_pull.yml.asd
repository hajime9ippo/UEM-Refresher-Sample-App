name: Deploy to Kubernetes

on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: self-hosted

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Build Docker image
        run: |
          docker build -t jlimhy/aspnetapp:latest .

      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKERUSERNAME }}
          password: ${{ secrets.DOCKERPASSWORD }}

      - name: Push Docker image
        run: |
          docker push muhdlai08/tryanderror:v1

      - name: Apply Kubernetes manifests
        run: |
          kubectl apply -f ./deployment.yaml
