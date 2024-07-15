kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

sleep 10

echo URL - https://$(kubectl get svc -n argocd argocd-server | awk '{print $4}' | tail -1)
echo Username - admin
echo Password - $(argocd admin initial-password -n argocd | head -1)
