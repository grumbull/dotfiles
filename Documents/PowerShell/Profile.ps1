$ConfigRoot = "$HOME\.config"
$ScoopApps = "$HOME\scoop\apps"

function Use-DotfilesRepo {
    git --git-dir="$HOME\.dotfiles" --work-tree "$HOME" @Args
}
set-alias "df" "Use-DotfilesRepo"

function Open-DotfilesWorkspace {
    code "$ConfigRoot\dotfiles.code-workspace"
}
Set-Alias "dfws" "Open-DotfilesWorkspace"

function Sync-Dotfiles {
    param (
        [Parameter(Mandatory = $true)]
        [string] $commitMessage
    )
    Write-Host "Syncing dotfiles to prevent conficts." -ForegroundColor Blue
    Use-DotfilesRepo pull
    Write-Host "Adding all tracked files under current location to staging." -ForegroundColor Blue
    Use-DotfilesRepo add . -u
    Write-Host "Commiting and pushing to remote." -ForegroundColor Blue
    Use-DotfilesRepo commit -m $commitMessage
    Use-DotfilesRepo push
    Write-Host "Done." -ForegroundColor Blue
}

# First time setup Notes:
#   VSCode registry stuff after scoop install
#   Winterm registry stuff after scoop install
#   Install Casdcadia Code NerdFont via  oh-my-posh font install
#   Install vsvim automatically?
#   git config --global init.defaultBranch main
#   Use-DotFiles config --local status.showUntrackedFiles no (if using a bare repo)

function Start-DailySync {
    param (
        [Parameter(Mandatory = $false)]
        [switch] $force
    )

    $lastRunTime = (scoop config).last_update
    $lastRunDate = $lastRunTime.Date
    $todayDate = (Get-Date).Date

    if (-not $force) {
        if ($lastRunDate -ge $todayDate) {
            Write-Host "Last sync time: $lastRunTime. Will not force sync. Use 'Start-DailySync -Force' to force sync." -ForegroundColor Yellow
            return;
        }
    }

    scoop update
    scoop export | Out-File "$configRoot\scoop\export.json" -Encoding ascii
    $dateString = Get-Date -Format 'yyyyMMddTHHmmss'
    $commitMsg = "Automated commit from Start-DailySync@$dateString"
    Sync-Dotfiles $commitMsg
}

function Start-Shell {
    $ompThemeName = 'quick-term'
    $ompThemePath = "$ScoopApps\oh-my-posh\current\themes\$ompThemeName.omp.json"
    oh-my-posh init pwsh --config $ompThemePath | Invoke-Expression
}

Start-Shell
Start-DailySync
