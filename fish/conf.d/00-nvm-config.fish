# Configuration nvm.fish - chargé avant nvm.fish
set --global nvm_default_version 24.18.1

# Bascule automatique sur la version d'un projet en entrant dans son dossier.
#
# nvm.fish ne pose aucun shim : il réécrit $PATH. Sans ce hook, le shell garde
# la version du dernier `nvm use`, y compris après avoir quitté le projet qui
# l'a demandée — on construit alors un repo sur une version qu'il ne déclare
# pas.
#
# Un dossier sans .nvmrc ne restaure rien tout seul : c'est le retour explicite
# au défaut ci-dessus, sinon la version précédente collerait.
function __nvm_use_nvmrc --on-variable PWD
    if test -f .nvmrc
        nvm use --silent 2>/dev/null
    else if test "$nvm_current_version" != "$nvm_default_version"
        nvm use --silent $nvm_default_version 2>/dev/null
    end
end
