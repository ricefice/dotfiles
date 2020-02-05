export GOPATH=$HOME/go

# INGRESS SETUP
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')

#GIT ALIASES
alias gdiff='git diff'
alias gstat='git status'
alias gush='git push'
alias gadd='git add'
alias kuc-chaos='kubectl config use-context chaos-admin@chaos'
alias kuc-eris='kubectl config use-context eris-admin@eris'
alias kuc-typhon='kubectl config use-context typhon-admin@typhon'
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

#k8 aliases & auto complete
alias k=kubectl
alias kccc='kubectl config current-context'
alias watchk8="watch 'kubectl get -o=name vs,dr,svc,deployment,cronjob,pod -n now-internal -o wide'"
alias watchk8spice="watch 'kubectl get -o=name vs,dr,svc,deployment,pod -n now-internal -o wide | grep spice'"
alias extract-cluster='kubectl get -o=name pods,svc,configmap,gateway,virtualservice,ingress,destinationrules,deployment,secret,serviceaccount -n now-internal -o yaml'
alias extract-cluster-debug='kubectl get -o=name ingress,svc,gateway,virtualservice,destinationrules,deployment --all-namespaces -o yaml'
#alias detailed-extract-cluster='kubectl get -o=name pvc,configmap,serviceaccount,secret,ingress,service,deployment,statefulset,hpa,job,cronjob --all-namespaces -o yaml'
alias clusterfk='k run -i --tty --rm --image=busybox:latest busybox'
alias clustercurl='k run -i --tty --rm cluster-curl --image=appropriate/curl:latest /bin/sh'
alias doker='docker'
alias kdelevicted="kubectl delete pods $(kubectl get pods --all-namespaces | grep Evicted | awk '{print $2, "-n", $1}')"

alias cssh='csshx'

## Port forward to the first istio-ingressgateway pod
#alias igpf='kubectl -n istio-system port-forward $(kubectl -n istio-system
#get pods -listio=ingressgateway -o=jsonpath="{.items[0].metadata.name}") 15000'
#
## Get the http routes from the port-forwarded ingressgateway pod (requires jq)
#alias iroutes='curl --silent http://localhost:15000/config_dump |
#jq '\''.configs.routes.dynamic_route_configs[].route_config.virtual_hosts[]|
#{name: .name, domains: .domains, route: .routes[].match.prefix}'\'''
#
## Get the logs of the first istio-ingressgateway pod
## Shows what happens with incoming requests and possible errors
#alias igl='kubectl -n istio-system logs $(kubectl -n istio-system get pods
#-listio=ingressgateway -o=jsonpath="{.items[0].metadata.name}") --tail=300'
#
## Get the logs of the first istio-pilot pod
## Shows issues with configurations or connecting to the Envoy proxies
#alias ipl='kubectl -n istio-system logs $(kubectl -n istio-system get pods
#-listio=pilot -o=jsonpath="{.items[0].metadata.name}") discovery --tail=300'
export HOMEBREW_GITHUB_API_TOKEN=e5bad2cb1947b8feff8fbe9281fd011ccb322576

#alias pf-kiali="kubectl port-forward $(k get all --all-namespaces | grep kiali | grep Running | awk '{print $2}') -n istio-system 20001:20001"
#alias pf-prometheus="kubectl port-forward $(k get all --all-namespaces | grep prometheus | grep Running | awk '{print $2}') -n istio-system 9090:9090"
#alias pf-grafana="kubectl port-forward $(k get all --all-namespaces | grep grafana | grep "Running" | awk '{print $2}' | tr -d '[:space:]') -n istio-system 3000:3000"

#kubectl port-forward $(k get pods --all-namespaces | grep grafana | grep Running | awk '{print $2, "-n", $1}') 3000:3000
alias pf-grafana="kubectl port-forward $(k get pods --all-namespaces | grep grafana | grep Running | awk '{print $2, "-n", $1}') 3000:3000"
alias pf-prometheus="kubectl port-forward $(k get pods --all-namespaces | grep prometheus | grep Running | awk '{print $2, "-n", $1}') 9090:9090"
alias pf-kiali="kubectl port-forward $(k get pods --all-namespaces | grep kiali | grep Running | awk '{print $2, "-n", $1}') 20001:20001"

## k8s autocomplete
#source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
#echo "source <(kubectl completion bash)" >> ~/.bash_profile

alias osdesc='uname -av && sw_vers && system_profiler SPSoftwareDataType && cat /System/Library/CoreServices/SystemVersion.plist'

#bash funcs
base64_encode() {
  echo -n $1 | base64 -w 0
}

#nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
source <(kubectl completion bash)

export PATH="/usr/local/opt/python/libexec/bin:$PATH"

