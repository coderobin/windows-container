#### Example Usage

```
docker run -d --ip 172.30.225.12 --name nuget --hostname nuget --restart=always -v C:\Users\dong\Documents\Deployments\volumes\nuget\Packages:C:/nuget.server.web/NuGet.Server.Web/Packages coderobin/nuget.server:latest
```


#### Best practices

**Do not** expose your NuGet Server directly to the world, put an NGINX before it.


#### Configuration

1. After the container is up and running, do ```docker exec -it nuget powershell``` to get into it, edit *c:\nuget.server.web\NuGet.Server.Web\web.config* file for the **ApiKey**:

```
    <!--
    Determines if an Api Key is required to push\delete packages from the server.
    -->
    <add key="requireApiKey" value="true" />
    <!--
    Set the value here to allow people to push/delete packages from the server.
    NOTE: This is a shared key (password) for all users.
    -->
    <add key="apiKey" value="**GENERATE_YOUR_APIKEY_HERE**" />
```

2. Edit *C:\nuget.server.web\NuGet.Server.Web\App_Data\UserCredentials.xml* file for UserName and Password:

```
<string>yourusername;yoursecurepassword;admin</string>
```

*admin* here is an arbitrary role name, it has no effects for now.

3. Then you can config your NuGet cli for sources with ApiKey and UserName and Password.

4. If you enable 1 and 2, please use an NGINX for SSL termination so that secrets travel in https


#### issues:

1. https://github.com/Microsoft/Virtualization-Documentation/issues/524
