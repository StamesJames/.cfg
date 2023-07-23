function config {
   git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
config config status.showUntrackedFiles no

loaded_configs=()
function import_config() {
    if [ -f $HOME/$1 ]; then
        source $HOME/$1
        loaded_configs+=( $1 )
    else
        echo "$HOME/$1 not found"
    fi
}

import_config .my-bash-config/functions/utils.sh
import_config .my-bash-config/functions/git_tracker.sh

