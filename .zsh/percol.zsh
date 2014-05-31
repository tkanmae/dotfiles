if [[ -d "${HOME}/.zsh/percol-functions" ]]; then
    for file (~/.zsh/percol-functions/*); do
        source "${file}"
    done
fi
