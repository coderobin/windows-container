$jenkins_ip = (Get-Item env:JENKINS_IP).Value
$secret = (Get-Item env:SECRET).Value
$slave_name = (Get-Item env:SLAVE_NAME).Value

if (-not (Test-Path .\slave.jar)) { 
    wget "http://$($jenkins_ip):8080/jnlpJars/slave.jar" -OutFile slave.jar
}

java -jar slave.jar -jnlpUrl "http://$($jenkins_ip):8080/computer/$($slave_name)/slave-agent.jnlp" -secret $secret
