# Prompt Fish - reproduit le style du .git-prompt Bash
# Format: HH:MM:SS[user]~/path(branch)$
# Branche verte si clean, rouge si dirty

function fish_prompt
    # Heure en gris
    set_color brblack
    echo -n (date +%H:%M:%S)
    set_color normal

    # [username] en blanc bold
    echo -n '['
    set_color --bold white
    echo -n $USER
    set_color normal
    echo -n ']'

    # Chemin en jaune (raccourci pour millenium)
    set -l cwd $PWD
    set -l millenium_base "/Volumes/workspace/emeria/millenium"
    if string match -q "$millenium_base*" $cwd
        set cwd (string replace $millenium_base "/millenium" $cwd)
    else
        # Remplace $HOME par ~
        set cwd (string replace $HOME "~" $cwd)
    end
    set_color yellow
    echo -n $cwd
    set_color normal

    # Branche Git (vert=clean, rouge=dirty)
    if git rev-parse --git-dir >/dev/null 2>&1
        set -l branch (git branch --show-current 2>/dev/null)
        if test -z "$branch"
            # Detached HEAD
            set branch (git rev-parse --short HEAD 2>/dev/null)
        end

        # Vérifie si le repo est clean
        if git diff --quiet HEAD 2>/dev/null && git diff --cached --quiet 2>/dev/null
            set_color brgreen
        else
            set_color brred
        end
        echo -n "($branch)"
        set_color normal
    end

    echo -n '$ '
end
