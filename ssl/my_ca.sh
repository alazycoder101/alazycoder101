#
# Create Certificate Authority and sign a certificate with Root CA
#
mkdir -p ~/.ca
cd ~/.ca
mkdir -p private certs crl
touch index.txt
echo 1000 > serial

echo "Type passphrase please [ENTER]:"
read password

# Generate Private Key
openssl ecparam -genkey -name secp384r1 | openssl ec -aes256 -passout pass:$password -out private/ca.key

# Create Certificate Authority Certificate
openssl req -config openssl_root.cnf -new -x509 -sha384 -extensions v3_ca -key private/ca.key -out certs/ca.crt -passin pass:$password
