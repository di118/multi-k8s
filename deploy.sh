
docker build -t di118/multi-client:latest -t di118/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t di118/multi-server:latest -t di118/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t di118/multi-worker:latest -t di118/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push di118/multi-client:latest
docker push di118/multi-server:latest
docker push di118/multi-worker:latest
docker push di118/multi-client:$SHA
docker push di118/multi-server:$SHA
docker push di118/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=di118/multi-server:$SHA
kubectl set image deployments/client-deployment client=di118/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=di118/multi-worker:$SHA