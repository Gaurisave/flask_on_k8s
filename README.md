This Repo will create API using flask. And run that on k8s EKS cluster.
For build - Docker and github actions
For cluster provisioning - Terraform
For deploy - Kubernetes helm

Requirements - 
s3 bucket - 
    name= TFstate-bucket
vpc
    tag.Name = testapp

How To -

Deploy - 
helm upgrade --kubeconfig testapp_cluster --install testapp-$ENV_NAME flask_on_k8s/helm \
-f flask_on_k8s/helm/values-$ENV_NAME.yaml \
--set imageName=$REPOSITORY/testapp:$GITHUB_SHA  \
-n $NAMESPACE
