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
