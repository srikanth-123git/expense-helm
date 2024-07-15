if [ "$1" == "install" ]; then
  kubectl create namespace argocd
  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
  kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

  sleep 10

  echo URL - https://$(kubectl get svc -n argocd argocd-server | awk '{print $4}' | tail -1)
  echo Username - admin
  echo Password - $(argocd admin initial-password -n argocd | head -1)

fi

#if [ "$1" == "jobs" ]; then
#  argocd login $(kubectl get svc -n argocd argocd-server | awk '{print $4}') --username admin --password $(argocd admin initial-password -n argocd | head -1) --insecure --grpc-web
#
#  for app in backend frontend ; do
#     argocd app create ${app}  --repo https://github.com/srikanth-123git/expense-helm --path chart --dest-namespace default --dest-server https://kubernetes.default.svc --grpc-web --values values/${app}.yaml
#  done
#
#fi