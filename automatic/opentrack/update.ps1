import-module au

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"                = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"           = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumTypeAll\s*=\s*)('.*')"    = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_GetLatest {

    $allVersions            = Invoke-WebRequest -Uri https://api.github.com/repos/opentrack/opentrack/releases -UseBasicParsing | ConvertFrom-Json;
    $lastStableVersion      = $allVersions | Where-Object { $_.prerelease -eq $false -and $_.assets } | Select-Object -First 1
    $latestInstallVersion   = $lastStableVersion.assets | Where-Object { $_.name -match 'win32-setup.exe$' };
    $latestInstallVersionUrl= $latestInstallVersion.browser_download_url;

    $latestVersion = $latestInstallVersion.name -split '-' | Select-Object -Last 1 -Skip 2

    $ChecksumType = 'sha256';

    $Latest = @{
        Version             = $latestVersion
        URL32               = $latestInstallVersionUrl
        ChecksumType32      = $ChecksumType
    };

    return $Latest;
}

update;