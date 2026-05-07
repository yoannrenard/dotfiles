if status is-interactive
    # ═══════════════════════════════════════════════════════════════════════════
    # Variables d'environnement
    # ═══════════════════════════════════════════════════════════════════════════
    set -gx LC_ALL C.UTF-8
    set -gx RA_NAME yoann

    # PATH
    fish_add_path -g $HOME/.local/bin
    fish_add_path -g $HOME/Library/pnpm

    # ═══════════════════════════════════════════════════════════════════════════
    # Alias généraux
    # ═══════════════════════════════════════════════════════════════════════════
    alias workspace 'cd /Volumes/workspace'
    alias ll 'ls -la'
    alias myra 'duck ra ls --self -l'

    # ═══════════════════════════════════════════════════════════════════════════
    # Alias Python
    # ═══════════════════════════════════════════════════════════════════════════
    alias python 'python3'

    # ═══════════════════════════════════════════════════════════════════════════
    # Alias Git
    # ═══════════════════════════════════════════════════════════════════════════
    alias git-clean-local 'git fetch -p origin && git checkout master && git branch --merged | grep -v master | xargs -n 1 git branch -d'
    alias git-clean-origin 'git fetch -p origin && git checkout master && git branch -r --merged | grep -v master | sed -e "s/.*origin\///" | xargs -n 1 git push origin --delete'

    # ═══════════════════════════════════════════════════════════════════════════
    # Alias NX / pnpm
    # ═══════════════════════════════════════════════════════════════════════════
    alias lintFix 'pnpm nx affected -t check:fix --parallel=10'
    alias build 'pnpm nx affected -t build --parallel=10'
    alias lint 'pnpm nx affected -t check --parallel=10'
    alias ts 'pnpm nx affected -t ts-check --parallel=8'
    alias nx_test 'pnpm nx affected -t test --exclude=plato --parallel=1'
    alias nx_test_ci 'pnpm nx affected -t test:ci --exclude=plato --parallel=1'
    alias all 'git fetch origin master:master && git rebase master && pnpm i && lint && ts && nx_test_ci'

    # ═══════════════════════════════════════════════════════════════════════════
    # Alias de navigation projets
    # ═══════════════════════════════════════════════════════════════════════════
    alias front-adb 'cd /Volumes/workspace/emeria/millenium/applications/front-adb'
    alias gateway-contract-graphql 'cd /Volumes/workspace/emeria/millenium/applications/gateway/contract-graphql'
    alias gateway-schemas 'cd /Volumes/workspace/emeria/millenium/applications/gateway/schemas'
    alias gateway-server 'cd /Volumes/workspace/emeria/millenium/applications/gateway/server'
    alias millenium 'cd /Volumes/workspace/emeria/millenium'
    alias plato 'cd /Volumes/workspace/emeria/millenium/applications/plato'
    alias service-lease 'cd /Volumes/workspace/emeria/millenium/applications/service-lease'
    alias smarties 'cd /Volumes/workspace/emeria/millenium/packages/smarties'
    alias transformers 'cd /Volumes/workspace/emeria/millenium/packages/transformers'
end

# ═══════════════════════════════════════════════════════════════════════════════
# Fonctions (définies hors du bloc is-interactive pour être disponibles partout)
# ═══════════════════════════════════════════════════════════════════════════════

# jake - exécute jake depuis le dossier jake-emeria
function jake
    pushd /Volumes/workspace/jake-emeria
    npx jake -q $argv
    popd
end

# make - recherche Makefile dans les dossiers parents
function make
    set -l dir $PWD
    while test "$dir" != "/"
        if test -f "$dir/Makefile"
            command make -f "$dir/Makefile" $argv
            return $status
        end
        set dir (dirname "$dir")
    end
    echo "Aucun Makefile trouvé dans les dossiers parents." >&2
    return 1
end
