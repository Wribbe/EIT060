truststore='truststore'
keystore='keystore'
port='8888'
pass='password'

create_caCert() {
    echo "Creating a selfigned cert"
    openssl req -x509 -newkey rsa:1024 -keyout "$cakey" -passout pass:$pass -out "$cacert" -subj "/CN=CA"
}

# Create truststore $1:name $2:password $3:alias
create_truststore()
{
    echo "Creating trust store: $1"
    keytool -import -v -file "$cacert" -alias $3 -keystore $1 -storepass $2 <<EOD
yes
EOD
}

# Create keystore with $1:name $2:password $3:CN-string $4:alias
create_keystore() {

    echo "Create keystore with key-pairs"
    echo "keytool -alias $4 -genkeypair -keystore $1 -storepass $2 (0: $0 1: $1 2:$2 3:$3 4:$4)"
    keytool -alias $4 -genkeypair -keystore $1 -storepass $2<<EOD
$3
.
.
.
.
.
yes
EOD
    echo "Import "$cacert" to $1"
    echo "keytool -import -alias CA  -file "$cacert" -keystore $1 -storepass $2 << EOD"
    keytool -import -alias CA -file "$cacert" -keystore $1 -storepass $2 << EOD
yes
EOD

}

# Create and sign a signreqest with $1:requestFileName $2:signedCertName $3:password $4:keystoreName $5: alias
create_and_sign_request() {

    echo "Creating sign-request"
    echo "keytool -alias $5 -certreq -file $1  -keystore $4 -storepass $3"
    keytool -alias $5 -certreq -file $1  -keystore $4 -storepass $3

    echo "Signing sign-request"
    echo "openssl x509 -req -in $1 -CA "$cacert" -CAkey "$cakey" -extfile v3.ext -CAcreateserial -out $2  pass:$3"
    openssl x509 -req -in $1 -CA "$cacert" -CAkey "$cakey" -extfile v3.ext -CAcreateserial -out $2 -passin pass:$3

    echo "Import signed request to $keystore"
    echo "keytool -import -alias $5 -v -file $2 -keystore $4 -storepass $3"
    keytool -import -alias $5 -v -file $2 -keystore $4 -storepass $3
}

rm stores/*
rm keys/*

cakey="keys/ca_key.pem"
cacert="keys/ca_cert.pem"

password="password"
CN_String="<atn08sen>(StefanEng)/<dat12emu>(Erik Munkby)/<dic13sli>(Sara Lindgren)"

create_caCert
create_truststore stores/test_store $password CN
create_keystore stores/test_keystore $password "$CN_String" key_pair
create_and_sign_request keys/certreq.pem keys/signedcert.pem $password stores/test_keystore key_pair
