**Question A:** What does the OpenSSL switch `-CAcreateserial` do? 

**Answer:**
>with this option the CA serial number file is created if it does not exist: it
>will contain the serial number "02" and the certificate being signed will have
>the 1 as its serial number. Normally if the -CA option is specified and the
>serial number file does not exist it is an error. - OpenSSL help text.

**Question B:** How can you tell keytool to generate a CSR for an X.509 version 3 client certificate (atstep 4), or tell OpenSSL to force generation of a version 3 certificate (at step 5)?

**Answer:**
Use command `openssl x509 -req -in ca.certreq -CA ca_cert.pem -CAkey ca_key.pem -extfile v3.ext -CAcreateserial -out signedkeys.cert -passin pass:$pass`

**Question C:** What are extensions and what do they contain?

**Answer:**
External keys that define the settings of the certificate, or explain the purpose of the certificate.
For example:
>basicConstraints=CA:TRUE

>basicConstraints=CA:FALSE

>basicConstraints=critical,CA:TRUE, pathlen:0

**Question D:** Is it possible to just make a copy of the client-side truststore,
why or why not?

**Answer:**
Yes it's possible, the keystores are only encrypted text. With the correct key it can be decrypted.

**Question E:** What is the purpose of each of the four password? That is, what does each password
protect?

**Answer:** 
Two keys are needed for decrypting the trust/key-store for reading, the other two are used to edit or add trusted keys to each respective store.

**Question F:** What does the server answer?

**Answer:** The client's reversed message.

**Question G:** How is the secure connection aected if you disable setNeedClientAuth(true) in the server?

**Answer:**

**Question H:** Show printouts, written directly in your submission email, from both server and
client (we know that this is not really a question, but you get the point).

**Answer:** 

**Client output:**
args[0] = localhost
args[1] = 8888

socket before handshake:
4db17d11[SSL_NULL_WITH_NULL_NULL: Socket[addr=localhost/127.0.0.1,port=8888,localport=38832]]

certificate name (subject DN field) on certificate received from server:
CN="<atn08sen>(StefanEng)/<dat12emu>(Erik Munkby)/<dic13sli>(Sara Lindgren)", OU=., O=., L=., ST=., C=.

certificate name (issuer DN field) on certificate received from server:
CN=CA

cert serial: 10792426362833763286
socket after handshake:
4db17d11[TLS_DHE_DSS_WITH_AES_256_CBC_SHA: Socket[addr=localhost/127.0.0.1,port=8888,localport=38832]]

secure connection established


>test for the project
sending 'test for the project' to server...done
received 'tcejorp eht rof tset' from server

**Server output:**

Server Started

client connected
client name (cert subject DN field): CN="<atn08sen>(StefanEng)/<dat12emu>(Erik Munkby)/<dic13sli>(Sara Lindgren)", OU=., O=., L=., ST=., C=.
issuer name (cert issuer DN field): CN=CA
cert serial: 10792426362833763286
1 concurrent connection(s)

received 'test for the project' from client
sending 'tcejorp eht rof tset' to client...done


