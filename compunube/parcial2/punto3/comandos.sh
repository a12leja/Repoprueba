mkdir clouddrive/punto3
------------------------
curl -O https://raw.githubusercontent.com/Azure-Samples/azure-voting-app-redis/master/azure-vote-all-in-one-redis.yaml
------------------------------
kubectl create -f azure-vote-all-in-one-redis.yaml
--------------------------
kubectl get pods
----------------------------
kubectl get svc