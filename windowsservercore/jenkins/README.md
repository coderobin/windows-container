### Update 30/12/2016

1.  Change base OS image from TP5 windowsservercore to RTM microsoft/windowsservercore.

2.  Add a Docker Volume of **JENKINS_HOME** and installer will use it properly, previous image mixed Jenkins system files with those files and folders that should live inside JENKINS_HOME.

3.  Although we haven't got our own *tini* solution, we came up a *simple_monitor.ps1* as ENTRYPOINT so that if the Jenkins service dies, the container will stop too.

### Example Usage

```
docker run -d --ip 172.30.225.13 --name jenkins --hostname jenkins --restart=always -v C:\Users\dong\Documents\Deployments\volumes\jenkins\jenkins_home:C:\JENKINS_HOME coderobin/jenkins:2.19
```

### Best Practices

**Do not** expose your Jenkins container directly to the world, put an NGINX before it.

### Original README

1.  Naive solution:
 
    One can build a Dockerfile with base image **windowsservercore**, and either install Jenkins by Chocolatey or manually, then call it a day.
 
    The problem: when the Jenkins msi installs, it will call an action to start the Jenkins windows service, and initialise all the secrets include *initialAdminPassword*, these files will be freezed in time in the docker image. If you build and run container this way, all instances will share the same secrets etc.

2.  The workaround:
   
    We made a msi transformation file *noStart.mst* ( it's binary ), all it does is to disable the step to call Start Service, so that the installation won't call the action. Therefore the initialisation happens when you do *docker run*, as it should be.

3.  Better solution and future work:

    * Try to **NOT** run Jenkins as a Windows Service, rather to be a foreground EXE, so that this process can be the proper docker process. ( This is effectively call Java with -war )
    * Maybe we could have something similar to [tini](https://github.com/krallin/tini), but we need to figure out the Unix Signal stuff.


