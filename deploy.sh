#############################
# docker command used in this file is the same that the one used in travis.yml file
# Build all our images with 2 tags: 
# - one being the latest 
# - another being a specific version number corresponding to the last commit id
docker build -t alanlachkar/multi-client:latest -t alanlachkar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alanlachkar/multi-server:latest -t alanlachkar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alanlachkar/multi-worker:latest -t alanlachkar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push each to Docker Hub
docker push alanlachkar/multi-client:latest
docker push alanlachkar/multi-server:latest
docker push alanlachkar/multi-worker:latest

docker push alanlachkar/multi-client:$SHA
docker push alanlachkar/multi-server:$SHA
docker push alanlachkar/multi-worker:$SHA

#############################
# kubectl command used in this file is the same that the one used in travis.yml file
# Apply all configuration files in "k8s" folder
kubectl apply -f k8s

#############################
# Imperative Kubernetes command set images on each deployment with a specific version
kubectl set image deployments/server-deployment server=alanlachkar/multi-server:$SHA
kubectl set image deployments/client-deployment client=alanlachkar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alanlachkar/multi-worker:$SHA