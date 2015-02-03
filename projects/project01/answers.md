###Question A: What does the OpenSSL switch `-CAcreateserial` do?
Answer: 
>with this option the CA serial number file is created if it does not exist: it
>will contain the serial number "02" and the certificate being signed will have
>the 1 as its serial number. Normally if the -CA option is specified and the
>serial number file does not exist it is an error. - OpenSSL help text.
