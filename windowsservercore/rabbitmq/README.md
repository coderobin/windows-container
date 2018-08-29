### Rabbitmq on Windows servercore base image

### Usage

```docker run -d --name rabbitmq --hostname rabbitmq -p 5672:5672 -p 15672:15672 -v C:\docker_volume\rabbitmq_data:C:\rabbitmq_data --restart=always coderobin/rabbitmq:10.0.14393.2363-3.6.6```

rabbitmq_management plugin is enabled, access by port number 15672.

The default guest/guest login no longer works, please get into the container e.g.

```docker exec -it rabbitmq powershell```

Then run the following commands to create a new admin user that can login from the Management UI:

```
PS C:\rabbitmq\sbin> .\rabbitmqctl.bat add_user newAdmin newPassword
PS C:\rabbitmq\sbin> .\rabbitmqctl.bat set_user_tags newAdmin administrator
PS C:\rabbitmq\sbin> .\rabbitmqctl.bat set_permissions -p / newAdmin ".*" ".*" ".*"
```

We are not handling clustering yet.

##### About Enabling plugins

Normally we could just call ```rabbitmq-plugins.bat enable rabbitmq_management --offline``` to enable our plugin. For Windows container though, we need to use a workaround. Because once you call above command, rabbitmq will populate $RABBITMQ_BASE directory, and leave a plain text file "enabled_plugins" there, so it could be picked up when you start the container first time; but we are also exporting the volume in our Dockerfile, and Windows Container expect to see an __EMPTY__ directory, so the docker build would simply throw error and quit.

Thus we put the "enabled_plugins" file out of this $RABBITMQ_BASE directory, and tell rabbitmq where to find it by using an Environment variable: RABBITMQ_ENABLED_PLUGINS_FILE.
