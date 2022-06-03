```
flux bootstrap github --owner rkdutta --repository k8-infra --private --path ./cd/base
```
# make directories
```
mkdir registry
mkdir registry/auth
mkdir registry/certs
```
# generate basic auth for container registry for admin user
```
docker run --rm --entrypoint htpasswd registry:2.6.2 -Bbn myuser mypasswd > registry/auth/htpasswd
```
# CA certificates
```
openssl genrsa -out registry/certs/container-registry-ca.key 2048
sudo sed -i '0,/RANDFILE/{s/RANDFILE/\#&/}' /etc/ssl/openssl.cnf
openssl req -new -key registry/certs/container-registry-ca.key -subj "/CN=CONTAINER-REGISTRY-CA" -out registry/certs/container-registry-ca.csr
openssl x509 -req -in registry/certs/container-registry-ca.csr -signkey registry/certs/container-registry-ca.key -CAcreateserial  -out registry/certs/container-registry-ca.crt -days 1000
```
# server certificates
```
openssl genrsa -out registry/certs/container-registry-server.key 2048
sudo sed -i '0,/RANDFILE/{s/RANDFILE/\#&/}' /etc/ssl/openssl.cnf
openssl req -new -key registry/certs/container-registry-server.key -subj "/CN=container-registry" -out registry/certs/container-registry-server.csr
openssl x509 -req -in registry/certs/container-registry-server.csr -CA registry/certs/container-registry-ca.crt -CAkey registry/certs/container-registry-ca.key -CAcreateserial  -out registry/certs/container-registry-server.crt -days 1000
```
# client certificates
```
openssl genrsa -out registry/certs/container-registry-client.key 2048
sudo sed -i '0,/RANDFILE/{s/RANDFILE/\#&/}' /etc/ssl/openssl.cnf
openssl req -new -key registry/certs/container-registry-client.key -subj "/CN=container-registry" -out registry/certs/container-registry-client.csr
openssl x509 -req -in registry/certs/container-registry-client.csr -CA registry/certs/container-registry-ca.crt -CAkey registry/certs/container-registry-ca.key -CAcreateserial  -out registry/certs/container-registry-client.crt -days 1000
```
# generating secrets
```
kubectl -n 04-container-registry create secret tls certs-secret --cert=registry/certs/container-registry-server.crt --key=registry/certs/container-registry-server.key
kubectl -n 04-container-registry create secret generic auth-secret --from-file=registry/auth/htpasswd
```
