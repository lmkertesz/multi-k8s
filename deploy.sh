docker build -t lmkertesz/multi-client-k8s:latest -t lmkertesz/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t lmkertesz/multi-server-k8s-pgfix:latest -t lmkertesz/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t lmkertesz/multi-worker-k8s:latest -t lmkertesz/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push lmkertesz/multi-client-k8s:latest
docker push lmkertesz/multi-server-k8s-pgfix:latest
docker push lmkertesz/multi-worker-k8s:latest

docker push lmkertesz/multi-client-k8s:$SHA
docker push lmkertesz/multi-server-k8s-pgfix:$SHA
docker push lmkertesz/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lmkertesz/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=lmkertesz/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=lmkertesz/multi-worker-k8s:$SHA