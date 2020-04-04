# shellcheck disable=SC2086
docker build -t odushyn/udemy-complex-client:latest -t odushyn/udemy-complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t odushyn/udemy-complex-server:latest -t odushyn/udemy-complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t odushyn/udemy-complex-worker:latest -t odushyn/udemy-complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push odushyn/udemy-complex-client:latest
docker push odushyn/udemy-complex-server:latest
docker push odushyn/udemy-complex-worker:latest

docker push odushyn/udemy-complex-client:$SHA
docker push odushyn/udemy-complex-server:$SHA
docker push odushyn/udemy-complex-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=odushyn/udemy-complex-server:$SHA
kubectl set image deployments/client-deployment client=odushyn/udemy-complex-client:$SHA
kubectl set image deployments/worker-deployment worker=odushyn/udemy-complex-worker:$SHA
