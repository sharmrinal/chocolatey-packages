import-module au

# ToDo :
#   - get latest changelog from https://sylpheed.sraoss.jp/en/news.html
#   - change projectSourceUrl when update (example for v3.6.0 : https://sylpheeectSourcd.sraoss.jp/sylpheed/v3.6/sylpheed-3.6.0.tar.bz2)
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
    $regex          = 'setup.exe$'
    $setup_name     = $page_source.Links | ? href -match $regex | Select-Object -First 1 -expand href

    $version        = $setup_name -split '-|_|.exe' | Select-Object -Last 1 -Skip 2
    if ($version.Split(".").Length -eq 2) {
        $version += '.0'
    } elseif ($version.Split(".").Length -eq 1) {
        $version += '0.0'
    }

    $url            = $url_ftp + $setup_name
    $ChecksumType   = 'sha256'

    $Latest = @{
        Version         = $version;
        URL32           = $url;
        ChecksumType32  = $ChecksumType;
    }

    return $Latest
}

update -NoCheckUrl -ChecksumFor 32 -NoCheckChocoVersion
