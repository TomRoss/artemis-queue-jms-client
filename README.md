# artemis-queue-jms-client
Artemis JMS point 2 point (Queue) client

To run hte client use command
~~~
mvn exec:java -D[property=value]
~~~
Client's availbe properties

**Common properties**
~~~
client.type - JMS producer or consumer [required]");
username - user name [guest]
password - user password [null]
connection.name - connection factory name. [ConnectionFactory]
queue.name - queue name. [jms/queue/testQueue]
queue.auto-create - auto create queue [false]
message.count - number of message to send. [1]
client.count - number of JMS clients. [1]
session.transacted - is the JMS session transacted. [false]
tx.batch.size - transaction batch size. [1]
log.batch.size - logging batch size. [10]
treconnect.attempts - how many times to try to reconnect [15]
reconnect.delay - how long to wait between reconnection attempts [10 seconds]
reinitialise.factory - create a brand new connection factory [false]
~~~
**Message sender only properties**
~~~
message.priority - message priority [Message.DEFALUT_PRIORITY]
message.send.delay - delay between each message send [0] (in milliseconds)
message.group - sets the value of JMSXGroupID [no group]
message.size - message size in KB
message.scheduled.delay - scheduled message delay (in milliseconds)
message.throw.exception - throw exception when consuming message [false]
message.expire - expire message after x milliseconds [0] (in milliseconds)

~~~
**Message consume only properties**
~~~
message.consume.delay - delay between message consumption [0] (in milliseconds)");
dup.detect - duplicate message detection. [false]");
~~~