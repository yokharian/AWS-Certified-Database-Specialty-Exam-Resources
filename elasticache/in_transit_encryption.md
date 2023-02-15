# Connecting to Amazon ElastiCache for Redis nodes enabled with in-transit encryption using redis-cli

[source](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/in-transit-encryption.html?icmpid=docs_console_unmapped#in-transit-encryption-enable)

To access data from ElastiCache for Redis nodes enabled with in-transit encryption, you use clients that work with Secure Socket Layer (SSL). You can also use redis-cli with TLS/SSL on Amazon linux and Amazon Linux 2.

## To use redis-cli to connect to a Redis cluster enabled with in-transit encryption on Amazon Linux 2 or Amazon Linux

1.  Download and compile the redis-cli utility. This utility is included in the Redis software distribution.
    
2.  At the command prompt of your EC2 instance, type the following commands:
    
    Amazon Linux 2
    
    `sudo yum -y install openssl-devel gcc wget http://download.redis.io/redis-stable.tar.gz tar xvzf redis-stable.tar.gz cd redis-stable make distclean make redis-cli BUILD_TLS=yes sudo install -m 755 src/redis-cli /usr/local/bin/`
    
    Amazon Linux
    
    `sudo yum install gcc jemalloc-devel openssl-devel tcl tcl-devel clang wget wget http://download.redis.io/redis-stable.tar.gz tar xvzf redis-stable.tar.gz cd redis-stable make redis-cli CC=clang BUILD_TLS=yes sudo install -m 755 src/redis-cli /usr/local/bin/`
    
    On Amazon Linux, you may also need to run the following additional steps:
    
    `sudo yum install clang CC=clang make sudo make install`
    
3.  After this, it is recommended that you run the optional `make-test` command.
    
4.  At the command prompt of your EC2 instance, type the following command, substituting the endpoint of your cluster and port for what is shown in this example.
    
    ``redis-cli -h `Primary or Configuration Endpoint` --tls -p 6379``
    
    For more information on finding the endpoint, see [Find your Node Endpoints](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/GettingStarted.ConnectToCacheNode.html#GettingStarted.FindEndpoints).
    
    The following example connects to a cluster with encryption and authentication enabled:
    
    ``redis-cli -h `Primary or Configuration Endpoint` --tls -a `'your-password'` -p 6379``
    

To work around this, you can use the `stunnel` command to create an SSL tunnel to the redis nodes. You then use redis-cli to connect to the tunnel to access data from encrypted Redis nodes.

###### To use redis-cli to connect to a Redis cluster enabled with in-transit encryption using stunnel

1.  Use SSH to connect to your client and install `stunnel`.
    
    `sudo yum install stunnel`
    
2.  Run the following command to create and edit file `'/etc/stunnel/redis-cli.conf'` simultaneously to add a ElastiCache for Redis cluster endpoint to one or more connection parameters, using provided output below as template:.
    
    `vi /etc/stunnel/redis-cli.conf  				 fips = no setuid = root setgid = root pid = /var/run/stunnel.pid debug = 7  delay = yes options = NO_SSLv2 options = NO_SSLv3 [redis-cli]    client = yes    accept = 127.0.0.1:6379    connect = primary.ssltest.wif01h.use1.cache.amazonaws.com:6379 [redis-cli-replica]    client = yes    accept = 127.0.0.1:6380    connect = ssltest-02.ssltest.wif01h.use1.cache.amazonaws.com:6379`
    
    In this example, the config file has two connections, the `redis-cli` and the `redis-cli-replica`. The parameters are set as follows:
    
    *   **client** is set to yes to specify this stunnel instance is a client.
        
    *   **accept** is set to the client IP. In this example, the primary is set to the Redis default 127.0.0.1 on port 6379. The replica must call a different port and set to 6380. You can use ephemeral ports 1024–65535. For more information, see [Ephemeral ports](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_ACLs.html#VPC_ACLs_Ephemeral_Ports) in the _Amazon VPC User Guide._
        
    *   **connect** is set to the Redis server endpoint. For more information, see [Finding connection endpoints](./Endpoints.html).
        
    
3.  Start `stunnel`.
    
    `sudo stunnel /etc/stunnel/redis-cli.conf`
    
    Use the `netstat` command to confirm that the tunnels started.
    
    `sudo netstat -tulnp | grep -i stunnel 				 tcp        0      0 127.0.0.1:6379              0.0.0.0:*                   LISTEN      3189/stunnel         tcp        0      0 127.0.0.1:6380              0.0.0.0:*                   LISTEN      3189/stunnel`
    
4.  Connect to the encrypted Redis node using the local endpoint of the tunnel.
    
    *   If no AUTH password was used during ElastiCache for Redis cluster creation, this example uses the redis-cli to connect to the ElastiCache for Redis server using complete path for redis-cli, on Amazon Linux:
        
        `/home/ec2-user/redis-stable/src/redis-cli -h localhost -p 6379`
        
        If AUTH password was used during Redis cluster creation, this example uses redis-cli to connect to the Redis server using complete path for redis-cli, on Amazon Linux:
        
         `` /home/ec2-user/redis-stable/src/redis-cli -h localhost -p 6379 -a `my-secret-password` ``
        
    
    OR
    
    *   Change directory to redis-stable and do the following:
        
        If no AUTH password was used during ElastiCache for Redis cluster creation, this example uses the redis-cli to connect to the ElastiCache for Redis server using complete path for redis-cli, on Amazon Linux:
        
        `src/redis-cli -h localhost -p 6379`
        
        If AUTH password was used during Redis cluster creation, this example uses redis-cli to connect to the Redis server using complete path for redis-cli, on Amazon Linux:
        
        `` src/redis-cli -h localhost -p 6379 -a `my-secret-password` ``	
        
    
    This example uses Telnet to connect to the Redis server.
    
    `telnet localhost 6379 			 Trying 127.0.0.1... Connected to localhost. Escape character is '^]'. auth MySecretPassword +OK get foo $3 bar`
    
5.  To stop and close the SSL tunnels, `pkill` the stunnel process.
    
    `sudo pkill stunnel`
 
