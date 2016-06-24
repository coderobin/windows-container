1.  Naive solution:
 
    One can build a Dockerfile with base image **windowsservercore**, and either install Jenkins by Chocolatey or manually, then call it a day.
 
    The problem: when the Jenkins msi installs, it will call an action to start the Jenkins windows service, and initialise all the secrets include *initialAdminPassword*, these files will be freezed in time in the docker image. If you build and run container this way, all instances will share the same secrets etc.

2.  The workaround:
   
    We made a msi transformation file *noStart.mst* ( it's binary ), all it does is to disable the step to call Start Service, so that the installation won't call the action. Therefore the initialisation happens when you do *docker run*, as it should be.

3.  Better solution and future work:

    * Try to **NOT** run Jenkins as a Windows Service, rather to be a foreground EXE, so that this process can be the proper docker process. ( This is effectively call Java with -war )
    * Maybe we could have something similar to [tini](https://github.com/krallin/tini), but we need to figure out the Unix Signal stuff.


