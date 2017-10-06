import-module au

# ToDo!
function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"       = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum32)'"
        }
     }
}

function global:au_GetLatest {
    $url_ftp                    = "https://sylpheed.sraoss.jp/sylpheed/win32/"
    $url_ftp_newest_files_first = $url_ftp + "?C=M;O=D"

    $page_source    = Invoke-WebRequest -Uri $url_ftp_newest_files_first -UseBasicParsing
    $regex          = '-win32.zip$'
    $setup_name     = $page_source.Links | ? href -match $regex | Select-Object -First 1 -expand href

    $version        = $setup_name -split '-|_|.exe' | Select-Object -Last 1 -Skip 1
    if ($version.Split(".").Length -eq 2) {
        $version += '.0'
    } elseif ($version.Split(".").Length -eq 1) {
        $version += '0.0'
    }

    $version_2_number = $version.Split(".")

    $url            = $url_ftp + $setup_name
    $ChecksumType   = 'sha256'

    $Latest = @{
        Version         = $version;
        URL32           = $url;
        ChecksumType32  = $ChecksumType;
        #LinkSource      = $linkSource;
    }

    return $Latest
}

update -NoCheckUrl -ChecksumFor 32
