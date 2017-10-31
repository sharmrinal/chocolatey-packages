import-module au

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]urlDownloadArchive\s*=\s*)('.*')" = "`$1'$($Latest.urlDirectDownload)'"
            "(^[$]checksum\s*=\s*)('.*')"           = "`$1'$($Latest.Checksum)'"
            "(^[$]checksumType\s*=\s*)('.*')"       = "`$1'$($Latest.ChecksumType)'"
        }
     }
}

function global:au_GetLatest {
    $urlRepository = 'https://forum.ru-board.com/topic.cgi?forum=5&topic=48142#2'

    $pageRepository         = Invoke-WebRequest -Uri $urlRepository -UseBasicParsing
    [regex]$regexLink       = 'Download \(Google Drive\)'
    $linkPageBeforeDownload = $pageRepository.Links | Where-Object outerHTML -match $regexLink
    $urlPageBeforeDownload  = $linkPageBeforeDownload.href

    $pageBeforeDownload     = Invoke-WebRequest -Uri $urlPageBeforeDownload -UseBasicParsing
    [regex]$regexUrlGDrive  = 'https:\/\/drive\.google\.com\/file\/d\/([a-zA-Z0-9]*)\/view'
    $urlFileGDrive          = $regexUrlGDrive.Matches($pageBeforeDownload.Links.href)[0].value
    $idFileGDrive           = $urlFileGDrive -split '/' | Select-Object -last 1 -Skip 1

    $urlDirectDownload = "https://drive.google.com/uc?export=download&id=$idFileGDrive"

    [regex]$regexVersion    = 'Windows Update MiniTool</b> ([0-9.]+)'
    $nameAndVersion         = $regexVersion.Matches($pageRepository.Content).Value
    $versionInverse         = $nameAndVersion -split " " | Select-Object -Last 1

    $arrayVersion   = $versionInverse -Split '\.'
    [array]::Reverse($arrayVersion)
    $version        = $arrayVersion -join '.'

    $checksumType       = 'sha256';
    $pathFileDownload   = "./wumt.zip";
    Invoke-WebRequest -Uri $urlDirectDownload -OutFile $pathFileDownload
    $checksum           = (Get-FileHash -Path $pathFileDownload -Algorithm $checksumType).Hash
    Remove-Item $pathFileDownload

    $Latest = @{
        Version             = $version
        urlDirectDownload   = $urlDirectDownload
        Checksum            = $checksum
        ChecksumType        = $checksumType
    };

    return $Latest;
}

Update-Package -ChecksumFor None