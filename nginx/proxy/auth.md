# Basic Auth
yum install http-tools

htpasswd -c /etc/nginx/htpasswd unixtutorial

```
auth_basic "Restricted";
auth_basic_user_file /etc/nginx/htpasswd;
```
