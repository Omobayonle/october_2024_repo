#!/bin/sh
set -e

# add the EKS Charts repo and update
helm repo add eks https://aws.github.io/eks-charts
helm repo update

# install the AWS Load Balancer Controller into kube-system
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  --namespace non-prod \
  --set clusterName=nonprod-eks-usw2 \
  --set region=us-west-2 \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller

helm install datadog \
  datadog/datadog \
  --namespace non-prod \
  --set datadog.site="datadoghq.com" \
  --set datadog.apiKey="<YOUR_DATADOG_API_KEY>" \
  --set clusterAgent.enabled=true \
