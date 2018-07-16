# Unprivileged Nginx

Some orchestrator as OpenShift need unprivileged services for security reasons. Nginx default image from Docker hub uses "root" as starter user even if the "nginx" user is used afterward. This image force a user with ID = 1001 to respect that condition.

This image:

- expose port 8080 instead of port 80
- use nginx user with ID:GID 1001:0 (root group, that's normal)
- remove the "user nginx;" directive inside configuration that is only needed when nginx is started with provileged user
- links access.log and error.log files to /dev/stdout and /dev/stderr 

## Build your own

Get that repository and build:

```
docker build -t your/nginx .
```

## Build on OpenShift

Get that repository and inside the project directory, use:

```
oc project you_project
oc import . --name=nginx
```

That will import the repository inside your OpenShift project, build image and start nginx.
