**Question A:** What does the OpenSSL switch `-CAcreateserial` do? 

**Answer:**
>with this option the CA serial number file is created if it does not exist: it
>will contain the serial number "02" and the certificate being signed will have
>the 1 as its serial number. Normally if the -CA option is specified and the
>serial number file does not exist it is an error. - OpenSSL help text.

**Question B:** How can you tell keytool to generate a CSR for an X.509 version 3 client certificate (atstep 4), or tell OpenSSL to force generation of a version 3 certificate (at step 5)?

