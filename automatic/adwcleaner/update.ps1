import-module au

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]urlBeforeDownload\s*=\s*)('.*')"  = "`$1'$($Latest.urlBeforeDownload)'"
            "(^[$]checksum\s*=\s*)('.*')"           = "`$1'$($Latest.Checksum32)'"
        }
     }
}

function global:au_GetLatest {

    $urlRepository  = 'https://toolslib.net/downloads/viewdownload/1-adwcleaner/files/?t=release';
    $regexAppsUrl   = '^/downloads/viewdownload/1-adwcleaner/files/\d+';
    $repoPageSource = Invoke-WebRequest -Uri $urlRepository;
    $allFilesLinks  = $repoPageSource.Links | Where-Object href -match $regexAppsUrl;
    $latestFileUrl  = $($allFilesLinks | Select-Object -First 1).href;
    $idLatestVersion= $latestFileUrl -split '/' | Where-Object {$_} | Select-Object -Last 1;

    $urlPageBeforeDownload      = "https://toolslib.net/downloads/finish/1-adwcleaner/$idLatestVersion/";
    $regexDownloadUrl           = '^https://download.toolslib.net/download/file/';
    $sourceBeforeDownloadPage   = Invoke-WebRequest -Uri $urlPageBeforeDownload;
    $allDownloadLinks           = $sourceBeforeDownloadPage.Links | Where-Object href -match $regexDownloadUrl;
    $latestDownloadUrl          = ($allDownloadLinks | Select-Object -First 1).href;

    $titlePageWithVersion   = $sourceBeforeDownloadPage.ParsedHtml.getElementsByTagName("h1")[0].innerHTML;
    $versionWithBrackets    = $titlePageWithVersion.Split(" ") | Where-Object {$_} | Select-Object -last 1;
    $version                = $versionWithBrackets -replace '[()]','';

    $ChecksumType = 'sha256';

    $Latest = @{
        Version             = $version
        urlBeforeDownload   = $urlPageBeforeDownload
        URL32               = $latestDownloadUrl
        ChecksumType32      = $ChecksumType
    };

    return $Latest;
}

$backupEnvChocoInstallDir       = $env:ChocolateyToolsLocation;
$env:ChocolateyToolsLocation    = $env:TEMP;

update -NoCheckUrl -NoCheckChocoVersion;

$env:ChocolateyToolsLocation    = $backupEnvChocoInstallDir;