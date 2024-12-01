docker build -t soniagurramavari/multi-client-k8s:latest -t soniagurramavari/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t soniagurramavari/multi-server-k8s:latest -t soniagurramavari/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t soniagurramavari/multi-worker-k8s:latest -t soniagurramavari/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push soniagurramavari/multi-client-k8s:latest
docker push soniagurramavari/multi-server-k8s:latest
docker push soniagurramavari/multi-worker-k8s:latest

docker push soniagurramavari/multi-client-k8s:$SHA
docker push soniagurramavari/multi-server-k8s:$SHA
docker push soniagurramavari/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=soniagurramavari/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=soniagurramavari/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=soniagurramavari/multi-worker-k8s:$SHA