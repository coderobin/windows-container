### Design

As a Jenkins build slave to be connected to the Jenkins master, the bare minimum we need:

1. Something that can run build, e.g. in our case we choose *coderobin/windows-build-uwp-461* as starting point, since it can build C# portable library. We might choose other for different purpose.

2. The Java Runtime, i.e. JRE

3. The Jenkins slave jar, and neccessary information for the connection to be established

### Versioning

Current version **coderobin/jenkins-slave:2.19** does not really tie to Jenkins v2.19, because the slave jar is downloaded from master at runtime. But we used this tag merely because we made both at the same time. In future we might need a better naming scheme.


### Example Usage

```
docker run -d --ip 172.30.225.14 --name build-1 --hostname build-1 --restart=always  -e "JENKINS_IP=172.30.225.13" -e "SECRET=REPLACE_WITH_REAL_SECRET" -e "SLAVE_NAME=build-1" -v C:\Users\dong\Documents\Deployments\volumes\jenkins_slave\jenkins:c:\jenkins coderobin/jenkins-slave:2.19
```

