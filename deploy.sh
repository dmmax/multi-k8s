docker build -t dmmax/multi-client:latest -t dmmax/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dmmax/multi-server:latest -t dmmax/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dmmax/multi-worker:latest -t dmmax/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dmmax/multi-client:latest
docker push dmmax/multi-server:latest
docker push dmmax/multi-worker:latest

docker push dmmax/multi-client:$SHA
docker push dmmax/multi-server:$SHA
docker push dmmax/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dmmax/multi-server:$SHA
kubectl set image deployments/client-deployment client=dmmax/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=dmmax/multi-worker:$SHA

kubectl create secret