CLUSTER_ENV := $(shell kubectl -n kube-system get configmap cluster-info -o jsonpath='{.data.environment_short}' --ignore-not-found)
ifndef CLUSTER_ENV
CLUSTER_ENV := local
endif

# kubectl get cm -n kube-system cluster-info

deploy: deploy_cluster-info deploy_traefik-ingress-controller

display_cluster-info: ## build image pymetrics/games with latest and dev tags
	kubectl kustomize cluster-info/overlays/$(CLUSTER_ENV)

deploy_cluster-info: ## build image pymetrics/games with latest and dev tags
	kubectl apply -k cluster-info/overlays/$(CLUSTER_ENV)

display_traefik-ingress-controller: ## build image pymetrics/games with latest and dev tags
	kubectl kustomize traefik-ingress-controller/overlays/$(CLUSTER_ENV)

deploy_traefik-ingress-controller: ## build image pymetrics/games with latest and dev tags
	kubectl apply -k traefik-ingress-controller/overlays/$(CLUSTER_ENV)
