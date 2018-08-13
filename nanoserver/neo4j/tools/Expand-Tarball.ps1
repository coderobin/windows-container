<#
For Expanding .tar.gz file
Ref: https://stackoverflow.com/questions/38776137/native-tar-extraction-in-powershell
#>

function Expand-Tarball() {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [System.String] $targzFile,
        [Parameter(Mandatory = $true, Position = 1)]
        [System.String] $outDirectory
    )
    try {
        Add-Type -Path 'C:\Program Files\NuGet\Packages\SharpZipLib.1.0.0-alpha2\lib\netstandard1.3\ICSharpCode.SharpZipLib.dll'

        $targz = [IO.File]::OpenRead($targzFile)
        $gzipStream = New-Object -TypeName ICSharpCode.SharpZipLib.GZip.GZipInputStream $targz
        $tarStream = New-Object -TypeName ICSharpCode.SharpZipLib.Tar.TarInputStream $gzipStream
        $tarball = [ICSharpCode.SharpZipLib.Tar.TarArchive]::CreateInputTarArchive($tarStream)
        $tarball.ExtractContents($outDirectory)
    }
    finally {
        $tarball.Close()
    }
}
