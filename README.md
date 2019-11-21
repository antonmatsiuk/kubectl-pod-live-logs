# Kubect wrapper for follow logs with labels
Currently kubectl doesn't allow simultaneous usage of -l and -f options while using `kubectk logs`
This wrapper for kubectl allows to get logs with "--follow" option and filtering on label, e.g -l k8s-app=APP_NAME

**Warning**: Script takes the logs from the first available pod only in case of multiple replicas!

**Usage**: 
```
/kubectl-pod-live-logs.sh -n NAMESPACE  -l LABELNAME=LABELVALUE
```
