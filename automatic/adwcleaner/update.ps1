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
    $repoPageSource = Invoke-WebRequest -Uri $urlRepository -UseBasicParsing;
    $allFilesLinks  = $repoPageSource.Links | Where-Object href -match $regexAppsUrl;
    $latestFileUrl  = $($allFilesLinks | Select-Object -First 1).href;
    $idLatestVersion= $latestFileUrl -split '/' | Where-Object {$_} | Select-Object -Last 1;

    $urlPageBeforeDownload      = "https://toolslib.net/downloads/finish/1-adwcleaner/$idLatestVersion/";
    $regexDownloadUrl           = '^https://download.toolslib.net/download/file/';
    $sourceBeforeDownloadPage   = Invoke-WebRequest -Uri $urlPageBeforeDownload -UseBasicParsing;
    $allDownloadLinks           = $sourceBeforeDownloadPage.Links | Where-Object href -match $regexDownloadUrl;
    $latestDownloadUrl          = ($allDownloadLinks | Select-Object -First 1).href;

    $appFile    = Invoke-WebRequest -URI $latestDownloadUrl -UseBasicParsing
    $appFileName= $appFile.Headers.'Content-Disposition'.split('"') | Where-Object {$_} | Select-Object -Last 1
    $version    = $appFileName -replace '.exe','' -split "_" | Select-Object -Last 1

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

update -NoCheckUrl;

$env:ChocolateyToolsLocation    = $backupEnvChocoInstallDir;