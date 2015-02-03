truststore='truststore'
keystore='keystore'
port='8888'
pass='password'

rm *.pem
rm -f $truststore
rm -f $keystore
rm serverkeystore
rm clientkeystore
rm clienttruststore 
rm servertruststore 

echo "Creating a selfigned cert"
openssl req -x509 -newkey  rsa:1024 -keyout ca_key.pem -passout pass:$pass -out ca_cert.pem -subj "/CN=CA" 

echo "Creating $truststore"
keytool -import -v -file ca_cert.pem -keystore $truststore -storepass $pass

echo "Create keystore with key-pairs"
keytool -alias key_pair -genkeypair  -keystore $keystore -storepass $pass  <<EOD
<atn08sen>(StefanEng)/<dat12emu>(Erik Munkby)/<dic13sli>(Sara Lindgren)/<dat12bli>(Björn Lindquist)
.
.
.
.
.
yes

EOD

echo "Import ca_cert.pem to $keystore"
keytool -import -file ca_cert.pem -keystore $keystore -storepass $pass

echo "Creating sign-request"
keytool -alias key_pair -certreq -file ca.certreq -keystore $keystore -storepass $pass

echo "Signing sign-request"
openssl x509 -req -in ca.certreq -CA ca_cert.pem -CAkey ca_key.pem -extfile v3.ext -CAcreateserial -out signedkeys.cert -passin pass:$pass

echo "Import signed request to $keystore"
keytool -import -alias key_pair -v -file signedkeys.cert -keystore $keystore -storepass $pass

echo "Store output"
keytool -list -v -keystore $keystore -storepass $pass > output.txt

echo "Copy stores"
cp $keystore serverkeystore
cp $keystore clientkeystore
cp $truststore clienttruststore 
cp $truststore servertruststore 

echo "Compiling client and server"
javac client.java server.java

echo "Starting server and client"
mate-terminal -x java server $port 
mate-terminal -x java client localhost $port 
