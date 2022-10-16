basepath=$(cd $(dirname "$0") && pwd)
# hard link to the custom vimrc file
ln -f "${basepath}/vimrc" ~/.vimrc
ln -f "${basepath}/coc-settings.json" ~/.vim/coc-settings.json

# git ignore global
ln -f "${basepath}/gitignore_global" ~/.gitignore_global
# git config --global core.excludesFile ~/.gitignore_global

# SBT
mkdir -p "${HOME}/.sbt/1.0/plugins"
ln -f "${basepath}/nvim/plugins.sbt" "${HOME}/.sbt/1.0/plugins/plugins.sbt"

# nvim
#ln -f "${basepath}/nvim/init.vim" "${HOME}/.config/nvim/init.vim"
#ln -f "${basepath}/nvim/lua/plugins.lua" "${HOME}/.config/nvim/lua/plugins.lua"

cp -r "${basepath}/nvim/" "${HOME}/.config/nvim/"
#ln -sf "${basepath}/nvim/init.vim" "${HOME}/.config/nvim/init.vim"
#ln -sf "${basepath}/nvim/plugins.sbt" "${HOME}/.config/nvim/plugins.sbt"
#mkdir -p "${HOME}/.config/nvim/lua/"
#ln -sf "${basepath}/nvim/lua/*" "${HOME}/.config/nvim/lua/"

# aliases
alias vim=nvim


vck () {
    # open files that match the given regex
    REGEX="$1"
    DIRECTORY=$2

    # remove arguments from the list of arguments, so that we can pass them to ack
    [ -n "$REGEX" ] && shift
    [ -n "$DIRECTORY" ] && shift

    FILES_MATCHING_REGEX=$(ack -l "$REGEX" $DIRECTORY $@)
    if [ -z "$FILES_MATCHING_REGEX" ]; then
        echo "No files matching '"$REGEX"'"
        return
    fi
    # remove trailing slashes from the regex that will be passed to VIM, as it does not
    # need them
    VIM_REGEX=$(echo "$REGEX" | tr -d '\\')
    echo "$FILES_MATCHING_REGEX" | xargs -o nvim +/"$VIM_REGEX"
}
