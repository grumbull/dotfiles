$ConfigRoot = "$HOME\.config"
$WintermConfigRoot = "$ConfigRoot\windows-terminal"

function Use-Dotfiles {
    git --git-dir="$HOME\.dotfiles" --work-tree "$HOME" @Args
}
set-alias "df" "Use-Dotfiles"

function Open-DotfilesWorkspace {
    code "$ConfigRoot\.config.code-workspace"
}
Set-Alias "dfws" "Open-DotfilesWorkspace"
Use-DotFiles config --local status.showUntrackedFiles no

scoop install 'https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json'

# Scoop install list
# VSCode registry stuff after scoop install

# Install Casdcadia Code NerdFont via
# oh-my-posh font install

# Install vsvim automatically?

scoop update
oh-my-posh font install

$ompThemeName = 'hotstick.minimal'
$ompThemePath = "$HOME\scoop\apps\oh-my-posh\current\themes\$ompThemeName.omp.json"
oh-my-posh init pwsh --config $ompThemePath | Invoke-Expression