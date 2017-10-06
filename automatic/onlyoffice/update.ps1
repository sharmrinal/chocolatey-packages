import-module au

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"       = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(^[$]checksum\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')"= "`$1'$($Latest.Checksum64)'"
        }
     }
}

function global:au_GetLatest {
    $url_repo = "https://github.com/ONLYOFFICE/DesktopEditors/releases/"

    $page_source    = Invoke-WebRequest -Uri $url_repo -UseBasicParsing
    $regex32        = 'DesktopEditors_x86.exe'
    $regex64        = 'DesktopEditors_x64.exe'

    $url_base       = "https://github.com"
    $relative_Link32= $page_source.Links | Where-Object href -match $regex32 | Select-Object -First 1 -ExpandProperty href
    $url32          = $url_base + $relative_Link32
    $relative_Link64= $page_source.Links | Where-Object href -match $regex64 | Select-Object -First 1 -ExpandProperty href
    $url64          = $url_base + $relative_Link64

    $name_with_version  = $relative_Link32 -Split '/' | Select-Object -Last 1 -Skip 1
    $version            = $name_with_version -Split '-' | Select-Object -Last 1

    $ChecksumType   = 'sha256'

    $Latest = @{
        Version         = $version;
        URL32           = $url32;
        URL64           = $url64;
        ChecksumType32  = $ChecksumType;
        ChecksumType64  = $ChecksumType;
    }

    return $Latest
}

update -NoCheckUrl
