# generate private key and Certificate Signing Request (CSR)
openssl req -new -newkey rsa:2048 -nodes -keyout sample.key -out sample.csr

# Verify Certificate Signing Request
openssl req -noout -text -in sample.csr

# Verify Certificate
openssl x509 -noout -text -in sample.crt

# Verify using MD5 SUM of the certificate and key file
openssl x509 -noout -modulus -in sample.crt | openssl md5
openssl rsa -noout -modulus -in sample.key | openssl md5


#
# Create Certificate Authority and sign a certificate with Root CA
#
echo secret > password
# encrypt password
openssl enc -aes256 -pbkdf2 -salt -in mypass -out password.enc
# decrypt password file
openssl enc -aes256 -pbkdf2 -salt -d -in password.enc

# Generate Private Key
openssl genrsa -des3 -passout file:password.enc -out ca.key 4096
# Verify Private Key
openssl rsa -noout -text -in ca.key -passin file:password.enc
# Create Certificate Authority Certificate
openssl req -new -x509 -days 365 -key ca.key -out ca.cert.pem -passin file:password.enc
# Verify certificate
openssl x509 -noout -text -in ca.cert.pem
openssl genrsa -des3 -passout file:password.enc -out server.key 4096
# insecure private key
openssl rsa -in server.key -out server.key.insecure
openssl req -new -key server.key -out server.csr -passin file:password.enc
# Verify Certifidate Signing Request
openssl req -noout -text -in server.csr

# Sign a certificate with CA
openssl x509 -req -days 365 -in server.csr -CA ca.cert.pem -CAkey ca.key -CAcreateserial -out server.crt -passin file:password.enc
# Verify 
openssl x509 -noout -text -in server.crt

# Verify server key
openssl rsa -noout -text -in server.key -passin file:password.enc


# openssl rsa -noout -text -in server.key
# openssl req -noout -text -in server.csr
# openssl x509 -noout -text -in server.crt
