docker build -t alanmorgan/multi-client:latest -t alanmorgan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alanmorgan/multi-server:latest -t alanmorgan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alanmorgan/multi-worker:latest -t alanmorgan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alanmorgan/multi-client:latest
docker push alanmorgan/multi-server:latest
docker push alanmorgan/multi-worker:latest

docker push alanmorgan/multi-client:$SHA
docker push alanmorgan/multi-server:$SHA
docker push alanmorgan/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alanmorgan/multi-server:$SHA
kubectl set image deployments/client-deployment client=alanmorgan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alanmorgan/multi-worker:$SHA

