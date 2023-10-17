$ConfigRoot = "$HOME\.config"
$ScoopApps = "$HOME\scoop\apps"

function Use-Dotfiles {
    git --git-dir="$HOME\.dotfiles" --work-tree "$HOME" @Args
}
set-alias "df" "Use-Dotfiles"

function Open-DotfilesWorkspace {
    code "$ConfigRoot\dotfiles.code-workspace"
}
Set-Alias "dfws" "Open-DotfilesWorkspace"

function Sync-Configs {
    # Copy "golden" VSCode/winterm config to the current install ala scoop.
    # Scoop "current" folder is just a shortcut to a versioned folder, so the source exists elsewhere.
    # Could consider a link, but not sure if hot-reload is support for links. This is good enough.
    Copy-Item -Force "$ConfigRoot\vscode\settings.json" "$ScoopApps\vscode\current\data\user-data\User"
    Copy-Item -Force "$ConfigRoot\winterm\settings.json" "$ScoopApps\windows-terminal\current\settings"
}


# First time setup Notes:
#   VSCode registry stuff after scoop install
#   Winterm registry stuff after scoop install
#   Install Casdcadia Code NerdFont via  oh-my-posh font install
#   Install vsvim automatically?
#   git config --global init.defaultBranch main
#   Use-DotFiles config --local status.showUntrackedFiles no (if using a bare repo)

scoop update
# On each powershell startup, export scoop installs to VCS tracked file

$ompThemeName = 'hotstick.minimal'
$ompThemePath = "$ScoopApps\oh-my-posh\current\themes\$ompThemeName.omp.json"
oh-my-posh init pwsh --config $ompThemePath | Invoke-Expression