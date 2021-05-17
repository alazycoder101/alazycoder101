# generate private key and Certificate Signing Request (CSR)
openssl req -new -newkey rsa:2048 -nodes -keyout sample.key -out sample.csr

# Verify Certificate Signing Request
openssl req -noout -text -in sample.csr

# Verify Certificate
openssl x509 -noout -text -in sample.crt

# Verify using MD5 SUM of the certificate and key file
openssl rsa -noout -modulus -in sample.key | openssl md5
openssl req -noout -text -in server.csr | openssl md5
openssl x509 -noout -modulus -in sample.crt | openssl md5


#
# Create Certificate Authority and sign a certificate with Root CA
#
echo secret > password
# encrypt password
openssl enc -aes256 -pbkdf2 -salt -in password -out password.enc
# decrypt password file
openssl enc -aes256 -pbkdf2 -salt -d -in password.enc

# Generate Private Key
# To make a private key using Elliptic Curve
openssl ecparam -list_curves | grep '256\|384'
openssl genpkey -out $name.key.pem -algorithm EC -pkeyopt ec_paramgen_curve:P-256 -aes256 -pass file:password.file

# To make a private key using RSA
openssl genrsa -des3 -passout file:password.enc -out ca.key 4096
# Verify Private Key
openssl rsa -noout -text -in ca.key -passin file:password.enc

# Create Certificate Authority Certificate
openssl req -config openssl_root.cnf -new -x509 -sha384 -extensions v3_ca -key ca.key -out ca.cert.pem -passin file:password.enc

openssl req -new -x509 -days 365 -key ca.key -out ca.cert.pem -passin file:password.enc
# Verify certificate
openssl x509 -noout -text -in ca.cert.pem

# Adding the Root Certificate to macOS Keychain
sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" ca.cert.pem

# Generate server key
openssl genrsa -des3 -passout file:password.enc -out server.key 4096
# Verify server key
openssl rsa -noout -text -in server.key -passin file:password.enc
# insecure private key
openssl rsa -in server.key -out server.key.insecure
openssl req -new -key server.key -out server.csr -passin file:password.enc
# Verify Certifidate Signing Request
openssl req -noout -text -in server.csr

# Sign a certificate with CA
openssl x509 -req -days 365 -in server.csr -CA ca.cert.pem -CAkey ca.key -CAcreateserial -out server.crt -passin file:password.enc
# 

# Verify certificate
openssl x509 -noout -text -in server.crt

# extract fingerprint
openssl x509 -pubkey < cert1.pem | \
    openssl pkey -pubin -outform der | \
    openssl dgst -sha256 -binary | base64
