# Reset K8s nodes and Add it again to Cluster


### Drain the node from master node / local machine
```bash
kubectl drain node-3   --ignore-daemonsets --delete-emptydir-data  
```
### Login to the node ssh 
```bash
ssh root@node-3
```

### Stop the kubelet running in the node
```bash
systemctl stop kubelet
```


### Reset kubeadm in the node
```bash
kubeadm reset
```
### Generate cluster join token from master node
```bash
kubeadm token create --print-join-command
```

### Copy paste the join command in node 
```bash
kubeadm join control-plan:9443 --token 9abcdef.hijkasdflwe --discovery-token-ca-cert-hash sha256:aswe23423wefadsf23aefaef323ewfwef
```
