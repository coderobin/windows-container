#### Example Usage

```
docker run -d -p 80:80 -p 443:443 --name nginx --hostname nginx --restart=always -v C:\Users\dong\Documents\Deployments\volumes\nginx\certs:c:\nginx-1.14.0\conf\certs coderobin/nginx:1.14.0
```

We use a volume mapping to manage SSL certificates.

#### Configuration

TODO
