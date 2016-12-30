while($true)
{
  sleep -Seconds 10

  $status = (Get-Service -Name Jenkins).Status

  if ($status -ne 'Running')
  {
    break;
  }
}

