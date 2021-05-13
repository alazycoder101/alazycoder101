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
echo $password > password
# encrypt password
openssl enc -aes-256-cbc -e -salt -v -in password -out password.enc

# Generate Private Key
openssl ecparam -genkey -name secp384r1 | openssl ec -aes256 -passout file:password.enc -out private/ca.key -passout file:password.enc

# Create Certificate Authority Certificate
openssl req -config openssl_root.cnf -new -x509 -sha384 -extensions v3_ca -key private/ca.key -out certs/ca.crt -passin file:password.enc
