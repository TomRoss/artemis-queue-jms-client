#!/bin/sh


java -jar -Dconnection.name=ConnectionFactory \
-Dqueue.name=jms/queue/testQueue \
-Dclient.type=producer \
-Dmessage.number = 1 \
-Dlog.batch.size=1 \
-Djavax.net.ssl.trustStore=/home/tomr/Work/OpenShift/amq-broker/ssl-cert/client-ts.jks \
-Djavax.net.ssl.trustStorePassword=secret \
-Djava.util.logging.manager=org.jboss.logmanager.LogManager \
-Djava.util.logging.config.file=/github/repos/cee/artemis-queue-jms-client/src/main/resources/logging.properties \
artemis-jms-queue-client.jar