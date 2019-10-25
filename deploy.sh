docker build -t kojinaka/multi-client:latest -t kojinaka/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kojinaka/multi-server:latest -t kojinaka/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kojinaka/multi-worker:latest -t kojinaka/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kojinaka/multi-client:latest
docker push kojinaka/multi-server:latest
docker push kojinaka/multi-worker:latest

docker push kojinaka/multi-client:$SHA
docker push kojinaka/multi-server:$SHA
docker push kojinaka/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kojinaka/multi-server:$SHA
kubectl set image deployments/client-deployment client=kojinaka/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kojinaka/multi-worker:$SHA

