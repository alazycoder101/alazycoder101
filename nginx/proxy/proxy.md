Install either NGINX or Apache and set up 3 virtual hosts/server blocks that will listen to the following ports: 8081, 8082, 8083. To check the ports have been set up correctly, make sure http://localhost:port displays "Hello From %port%" (Example: the first host should print "Hello From 8081").

Use NGINX/HAProxy or any other similar software to set up a load balancer on port 8080 (this port is already in use and your task is to detect and kill the process using it; make sure you do not kill all the processes as the challenge requires you to clear port 8080 only). The load balancer should redirect requests to the following ports 8081, 8082, 8083 using the round-robin strategy.


```
upstream servers {
          server localhost:8081;
          server localhost:8082;
          server localhost:8083;
        }

server {
		listen     8080;
		location / {
			proxy_pass http://servers;
		}
}

server {
		listen     8081;
		location / {
		  return 200 'Hello From $server_port';
		}
}
server {
		listen     8082;
		location / {
		  return 200 'Hello From $server_port';
		}
}
server {
		listen     8083;
		location / {
		  return 200 'Hello From $server_port';
		}
}
```

find the process using 8080 and kill it.

```
ss -lp
```
