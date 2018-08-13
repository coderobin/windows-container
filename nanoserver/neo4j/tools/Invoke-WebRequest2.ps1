<#
Designed for Windows Nano Container
Due to the issue: https://github.com/PowerShell/PowerShell/issues/2896
Original Invoke-WebRequest Comlet won't work for download e.g. Java JRE
#>

function Invoke-WebRequest2() {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [System.Uri] $url,
        [Parameter(Mandatory = $true, Position = 1)]
        [System.String] $outFile,
        [Parameter(Position = 2)]
        [System.Net.Cookie] $cookie = $null
    )
    Add-Type -AssemblyName System.Net.Http
    $httpClientHandler = New-Object System.Net.Http.HttpClientHandler

    if ($cookie) {
        $httpClientHandler.CookieContainer.Add($url, $cookie)
        $httpClientHandler.AllowAutoRedirect = $false
    }

    $httpClient = New-Object System.Net.Http.HttpClient $httpClientHandler

    $response = $httpClient.GetAsync($url).Result

    while ($response.StatusCode -eq "302") {
        $url = $response.Headers.Location.AbsoluteUri
        $response = $httpClient.GetAsync($url).Result
    }

    if ($response.StatusCode -eq "200") {
        $fs = New-Object System.IO.FileStream($outFile, [System.IO.FileMode]::Create)
        $response.Content.CopyToAsync($fs).Wait()
        $fs.Close()
    }
}
