
mkdir registry
mkdir registry/auth
mkdir registry/certs

# generate basic auth for container registry for admin user
docker run --rm --entrypoint htpasswd registry:2.6.2 -Bbn myuser mypasswd > auth/htpasswd

# CA certificates
openssl genrsa -out container-registry-ca.key 2048
sudo sed -i '0,/RANDFILE/{s/RANDFILE/\#&/}' /etc/ssl/openssl.cnf
openssl req -new -key container-registry-ca.key -subj "/CN=CONTAINER-REGISTRY-CA" -out container-registry-ca.csr
openssl x509 -req -in container-registry-ca.csr -signkey container-registry-ca.key -CAcreateserial  -out container-registry-ca.crt -days 1000

# server certificates
openssl genrsa -out container-registry-server.key 2048
sudo sed -i '0,/RANDFILE/{s/RANDFILE/\#&/}' /etc/ssl/openssl.cnf
openssl req -new -key container-registry-server.key -subj "/CN=container-registry-server" -out container-registry-server.csr
openssl x509 -req -in container-registry-server.csr -CA container-registry-ca.crt -CAkey container-registry-ca.key -CAcreateserial  -out container-registry-server.crt -days 1000

# client certificates
openssl genrsa -out container-registry-client.key 2048
sudo sed -i '0,/RANDFILE/{s/RANDFILE/\#&/}' /etc/ssl/openssl.cnf
openssl req -new -key container-registry-client.key -subj "/CN=container-registry-server" -out container-registry-client.csr
openssl x509 -req -in container-registry-client.csr -CA container-registry-ca.crt -CAkey container-registry-ca.key -CAcreateserial  -out container-registry-client.crt -days 1000

# generating secrets
kubectl -n 04-container-registry create secret tls certs-secret --cert=registry/certs/container-registry-server.crt --key=registry/certs/container-registry-server.key
kubectl -n 04-container-registry create secret generic auth-secret --from-file=registry/auth/htpasswd
