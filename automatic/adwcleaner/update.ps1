import-module au

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]urlToken\s*=\s*)('.*')"   = "`$1'$($Latest.TokenPage)'"
            "(^[$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
     }
}

function global:au_GetLatest {

    $url_repo           = "https://toolslib.net/downloads/viewdownload/1-adwcleaner/files/?t=release"
    $page_repo_source   = Invoke-WebRequest -Uri $url_repo
    $html_element_link  = $page_repo_source.Links | Where-Object href -match "^/downloads/viewdownload/1-adwcleaner/files/\d+" | Select-Object -First 1
    
    $id_latest_version = $html_element_link.href -split '/' | ? {$_} | Select-Object -Last 1

    $url_download_page_token    = "https://toolslib.net/downloads/finish/1-adwcleaner/" + $id_latest_version + "/"
    $page_token_source          = Invoke-WebRequest -Uri $url_download_page_token

    $url_download = ($page_token_source.Links | Where-Object href -match "^https://download.toolslib.net/download/file/" | Select-Object -First 1).href

    $title_with_version = $page_token_source.ParsedHtml.getElementsByTagName("h1")[0].innerHTML
    $version            = ($title_with_version.Split(" ") | Where-Object {$_} | Select-Object -last 1) -replace '[()]',''

    $ChecksumType = 'sha256'

    $Latest = @{
        Version         = $version;
        TokenPage       = $url_download_page_token;
        URL32           = $url_download;
        ChecksumType32  = $ChecksumType;
    }

    return $Latest
}

$backupEnvChocolateyToolsLocation = $env:ChocolateyToolsLocation;

$env:ChocolateyToolsLocation = $env:TEMP;

Write-Host $env:ChocolateyToolsLocation
update -NoCheckUrl -NoCheckChocoVersion

$env:ChocolateyToolsLocation = $backupEnvChocolateyToolsLocation;

Write-Host "DEBUG"