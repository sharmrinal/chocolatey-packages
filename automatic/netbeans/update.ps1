import-module au;

function global:au_SearchReplace {
    @{
        '.\legal\VERIFICATION.txt' = @{
            "(?i)(\s+x32:).*"                           = "`${1} $($Latest.URL32)"
            "(?i)(checksum32:).*"                       = "`${1} $($Latest.Checksum32)"
            "(?i)(Get-RemoteChecksum).*"                = "`${1} $($Latest.URL32)"
            "(?i)(File 'LICENSE.txt' obtained from:).*" = "`${1} $($Latest.License)"
        }
     };
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge;
}

function global:au_GetLatest {
    $roadmapUrl   = 'https://netbeans.org/community/releases/roadmap.html'
    $roadmapPage  = Invoke-WebRequest -Uri $roadmapUrl -UseBasicParsing

    $link           = $roadmapPage.Links | Where-Object href -match '^/community/releases/\d+' | Select-Object -First 1
    [regex]$regex   = '\d+(\.\d+)+'
    $latestVersion  = $regex.Matches($link.outerHTML).value

    $releasesUrl = "http://download.netbeans.org/netbeans/$latestVersion/final/bundles/netbeans-$latestVersion-windows.exe"

    $latestVerionWithoutPoint = $latestVersion -replace '\.',''

    $outputLicenseFile  = ".\legal\LICENSE.txt"
    $licenceUrl         = "https://netbeans.org/downloads/licence/$latestVersion/nb$latestVerionWithoutPoint-LICENSE.txt"
    Invoke-WebRequest -Uri $licenceUrl -UseBasicParsing -OutFile $outputLicenseFile

    $Latest = @{
        Version = $latestVersion
        URL32   = $releasesUrl
        License = $licenceUrl
    }

    return $Latest
}

Update-Package -ChecksumFor none
