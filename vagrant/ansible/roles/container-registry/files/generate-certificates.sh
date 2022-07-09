#/bin/sh
mkdir "registry" && mkdir registry/auth && mkdir registry/certs

# openssl genrsa -out registry/certs/container-registry-ca.key 2048
# sudo sed -i '0,/RANDFILE/{s/RANDFILE/\#&/}' /etc/ssl/openssl.cnf
# openssl req -new -key registry/certs/container-registry-ca.key -subj "/CN=CONTAINER-REGISTRY-CA" -out registry/certs/container-registry-ca.csr
# openssl x509 -req -in registry/certs/container-registry-ca.csr -signkey registry/certs/container-registry-ca.key -CAcreateserial  -out registry/certs/container-registry-ca.crt -days 1000
#
# openssl genrsa -out registry/certs/container-registry-server.key 2048
# sudo sed -i '0,/RANDFILE/{s/RANDFILE/\#&/}' /etc/ssl/openssl.cnf
# openssl req -new -key registry/certs/container-registry-server.key -subj "/CN=container-registry" -out registry/certs/container-registry-server.csr -config registry/certs/openssl.cnf
# openssl x509 -req -in registry/certs/container-registry-server.csr -CA registry/certs/container-registry-ca.crt -CAkey registry/certs/container-registry-ca.key -CAcreateserial  -out registry/certs/container-registry-server.crt -days 1000 -extensions v3_req -extfile registry/certs/openssl.cnf
#
# openssl genrsa -out registry/certs/container-registry-client.key 2048
# sudo sed -i '0,/RANDFILE/{s/RANDFILE/\#&/}' /etc/ssl/openssl.cnf
# openssl req -new -key registry/certs/container-registry-client.key -subj "/CN=container-registry" -out registry/certs/container-registry-client.csr -config registry/certs/openssl.cnf
# openssl x509 -req -in registry/certs/container-registry-client.csr -CA registry/certs/container-registry-ca.crt -CAkey registry/certs/container-registry-ca.key -CAcreateserial  -out registry/certs/container-registry-client.crt -days 1000 -extensions v3_req -extfile registry/certs/openssl.cnf
