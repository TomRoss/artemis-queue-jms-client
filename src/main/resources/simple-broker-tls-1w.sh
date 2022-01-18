# keystore and trustore build
# 0. Create server's keystore
# -deststoretype pkcs12
# 1. First, generate a self-signed certificate for the broker keystore
#keytool -genkey -noprompt -alias broker-ocp -keyalg RSA -keysize 2048 -validity 3650 -keystore broker-ks.jks \
    -dname "cn=Tom Ross,ou=GSS,o=RedHat,l=Reading,st=Berks,C=UK" -keypass secret -storepass secret


# 2. Next, export the certificate so that it can be shared with clients:
#keytool -export -noprompt -alias broker-ocp -file broker-rex-cert.pem -keystore broker-ks.jks -storepass secret

# 3. Create a client truststore that imports the broker certificate:
#keytool -import -noprompt -alias broker-ocp -file broker-rex-cert.pem -keystore client-ts.jks -storepass secret

#62698  keytool -genkey -noprompt -alias rex-ssl -keyalg RSA -keysize 2048 -validity 3650 -keystore broker-ks.jks \\n-dname "cn=Tom Ross,ou=GSS,o=RedHat,l=Reading,st=Berks,C=UK" -keypass secret -storepass secret
#62699  ll
#62700  keytool -importkeystore -srckeystore broker-ks.jks  \\n-destkeystore broker-rex.p12 \\n-srcstoretype jks -deststoretype pkcs12


#openssl pkcs12 -in broker-rex.p12 -out broker-rex.pem -passwd secret

#!/bin/bash


KEY_PASS=secret STORE_PASS=secret CA_VALIDITY=365000 VALIDITY=36500

keytool -storetype pkcs12 -keystore server-ca-keystore.p12 -storepass $STORE_PASS -keypass $KEY_PASS -alias server-ca -genkey -keyalg "RSA" -keysize 2048 -dname "CN=ActiveMQ Artemis Server Certification Authority, OU=Artemis, O=ActiveMQ" -validity $CA_VALIDITY -ext bc:c=ca:true

keytool -storetype pkcs12 -keystore server-ca-keystore.p12 -storepass $STORE_PASS -alias server-ca -exportcert -rfc > server-ca.crt

keytool -keystore server-ca-truststore.p12 -storepass $STORE_PASS -keypass $KEY_PASS -importcert -alias server-ca -file server-ca.crt -noprompt

keytool -keystore server-keystore.jks -storepass $STORE_PASS -keypass $KEY_PASS -alias server -genkey -keyalg "RSA" -keysize 2048 -dname "CN=ActiveMQ Artemis Server, OU=Artemis, O=ActiveMQ, L=AMQ, S=AMQ, C=AMQ" -validity $VALIDITY -ext bc=ca:false -ext eku=sA -ext san=dns:rex,ip:192.168.1.108

keytool -keystore server-keystore.jks -storepass $STORE_PASS -alias server -certreq -file server.csr

keytool -keystore server-ca-keystore.p12 -storepass $STORE_PASS -alias server-ca -gencert -rfc -infile server.csr -outfile server.crt -validity $VALIDITY -ext bc=ca:false -ext san=dns:rex,ip:192.168.1.108

keytool -keystore server-keystore.jks -storepass $STORE_PASS -keypass $KEY_PASS -importcert -alias server-ca -file server-ca.crt -noprompt

keytool -keystore server-keystore.jks -storepass $STORE_PASS -keypass $KEY_PASS -importcert -alias server -file server.crt
