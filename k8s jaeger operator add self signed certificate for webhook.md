## k8s jaeger operator add self signed certificate for webhook
1. Generate CA key and certificate:
```bash
openssl req -x509 -newkey rsa:4096 -keyout ca.key -out ca.crt -sha256 -days 3650 -nodes -subj "/C=RS/ST=RS/L=BELGRADE/O=MAINFLUX/OU=MAINFLUX/CN=Mainflux_Root_CA/subjectAltName=DNS:mf.svc,DNS:*.mf.svc"
```

2. Generate the server key:
```bash
openssl genrsa -out mainflux-server.key 2048
```

3. Create a configuration file for the server certificate signing request (CSR):
```bash
cat <<EOF >>mainflux-server-csr.config
[req]
req_extensions = v3_req
distinguished_name = dn
prompt = no

[dn]
CN = mf.svc   ## <FQDN of your RBA server>
C  = RS        ## <Country Name (2 letter code)>
ST = RS       ## <State Name (2 letter code)>
L  = BELGRADE  ## <Locality Name (eg, city)>
O  = MAINFLUX  ## <Organization Name (eg, company)>
OU = MAINFLUX ##<Organizational Unit Name (eg, section)>

[v3_req]
subjectAltName = @alt_names

[alt_names]
DNS.1 = *.mf.svc
DNS.2 = jaeger-operator-webhook-service.mf.svc
EOF
```

4. Generate the server certificate signing request (CSR):
```bash
openssl req -new -key mainflux-server.key -sha256 -out mainflux-server.csr -subj "/C=RS/ST=RS/L=BELGRADE/O=MAINFLUX/OU=MAINFLUX/CN=Mainflux_Root_CA/subjectAltName=DNS:mf.svc,DNS:*.mf.svc"
```

5. Generate the server certificate using the CSR and CA:
```bash
openssl req -new -key mainflux-server.key -sha256 -out mainflux-server.csr -config mainflux-server-csr.config -extensions v3_req
openssl x509 -req -sha256 -in mainflux-server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out mainflux-server.crt -days 365 -extfile mainflux-server-csr.config -extensions v3_req
```

6. Export the CA certificate as a base64-encoded string:
```bash
export CA_BUNDLE=$(cat ca.crt | base64 | tr -d '\n')
```

7. Patch the MutatingWebhookConfiguration with the CA bundle:
```bash
kubectl patch MutatingWebhookConfiguration/jaeger-operator-mutating-webhook-configuration -n mf --type JSON -p '[{"op": "add", "path": "/webhooks/0/clientConfig/caBundle", "value":"'${CA_BUNDLE}'"}]'
kubectl patch MutatingWebhookConfiguration/jaeger-operator-mutating-webhook-configuration -n mf --type JSON -p '[{"op": "add", "path": "/webhooks/1/clientConfig/caBundle", "value":"'${CA_BUNDLE}'"}]'
```

8. Patch the ValidatingWebhookConfiguration with the CA bundle:
```bash
kubectl patch ValidatingWebhookConfiguration/jaeger-operator-validating-webhook-configuration -n mf --type JSON -p '[{"op": "add", "path": "/webhooks/0/clientConfig/caBundle", "value":"'${CA_BUNDLE}'"}]'
```
