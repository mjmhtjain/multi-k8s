docker build -t mjmhtjain/multi-client:latest -t mjmhtjain/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mjmhtjain/multi-server:latest -t mjmhtjain/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mjmhtjain/multi-worker:latest -t mjmhtjain/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mjmhtjain/multi-client:latest
docker push mjmhtjain/multi-server:latest
docker push mjmhtjain/multi-worker:latest

docker push mjmhtjain/multi-client:$SHA
docker push mjmhtjain/multi-server:$SHA
docker push mjmhtjain/multi-worker:$SHA

kubectl apply -f k8s/

kubectl set image deployments/client-deployment client-deployment=mjmhtjain/multi-client:$SHA
kubectl set image deployments/server-deployment server-deployment=mjmhtjain/multi-server:$SHA
kubectl set image deployments/worker-deployment worker-deployment=mjmhtjain/multi-worker:$SHA