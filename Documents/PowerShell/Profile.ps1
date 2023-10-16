$ConfigRoot = "$HOME\.config"
$WintermConfigRoot = "$ConfigRoot\windows-terminal"

function Use-Dotfiles {
    git --git-dir="$HOME\.dotfiles" --work-tree "$HOME" @Args
}
set-alias "df" "Use-Dotfiles"

function Open-DotfilesWorkspace {
    code "$ConfigRoot\dotfiles.code-workspace"
}
Set-Alias "dfws" "Open-DotfilesWorkspace"
Use-DotFiles config --local status.showUntrackedFiles no


# On each powershell startup, export scoop installs to VCS tracked file

# Scoop install list
# scoop install 'https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json'

# VSCode registry stuff after scoop install

# Install Casdcadia Code NerdFont via
# oh-my-posh font install

# Install vsvim automatically?

scoop update
oh-my-posh font install

$ompThemeName = 'hotstick.minimal'
$ompThemePath = "$HOME\scoop\apps\oh-my-posh\current\themes\$ompThemeName.omp.json"
oh-my-posh init pwsh --config $ompThemePath | Invoke-Expression