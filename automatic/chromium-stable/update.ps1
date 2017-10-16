import-module au

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"                = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"           = "`$1'$($Latest.Checksum32)'"
            "(^[$]url64\s*=\s*)('.*')"              = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')"         = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumTypeAll\s*=\s*)('.*')"    = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_GetLatest {

    $allVersions                = Invoke-WebRequest -Uri https://api.github.com/repos/henrypp/chromium/releases -UseBasicParsing | ConvertFrom-Json
    $allStableVersions          = $allVersions | Where-Object {$_.body -match "stable"}
    $latestStableVersionNumber  = ($allStableVersions[0].tag_name.split('-') | Select-Object -First 1) -replace 'v',''
    $allLatestStablesVersions   = $allVersions  | Where-Object {$_.tag_name -match $latestStableVersionNumber}
    
    $32LatestVersion        = $allLatestStablesVersions  | Where-Object {$_.tag_name -match $latestStableVersionNumber -and $_.tag_name -match "win32"}
    $32LatestSyncInstallUrl = ($32LatestVersion.assets | Where-Object name -match "-sync.exe").browser_download_url
    
    $64LatestVersion        = $allLatestStablesVersions  | Where-Object {$_.tag_name -match $latestStableVersionNumber -and $_.tag_name -match "win64"}
    $64LatestSyncInstallUrl = ($64LatestVersion.assets | Where-Object name -match "-sync.exe").browser_download_url

    $ChecksumType = 'sha256';

    $Latest = @{
        Version             = $latestStableVersionNumber
        URL32               = $32LatestSyncInstallUrl
        ChecksumType32      = $ChecksumType
        URL64               = $64LatestSyncInstallUrl
        ChecksumType64      = $ChecksumType
    };

    return $Latest;
}

update -NoCheckUrl -NoCheckChocoVersion;