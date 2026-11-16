#!/usr/bin/env bash
# Met en place les fichiers de ce dépôt sur la machine courante (macOS ou Linux).
#
#   ./installer.sh
#
# Chaque fichier est relié par un lien symbolique : modifier le fichier dans le
# dépôt suffit, il n'y a rien à recopier. Un fichier déjà présent à la cible et
# qui n'est pas ce lien est mis de côté en .sauvegarde-<date>, jamais écrasé.
# Le script peut être relancé sans risque.
set -euo pipefail

DEPOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

relier() {
  local source="$DEPOT/$1" cible="$2"
  mkdir -p "$(dirname "$cible")"
  if [ -L "$cible" ] && [ "$(readlink "$cible")" = "$source" ]; then
    echo "  déjà en place  $cible"
    return
  fi
  if [ -e "$cible" ] || [ -L "$cible" ]; then
    local sauvegarde="$cible.sauvegarde-$(date +%Y%m%d-%H%M%S)"
    mv "$cible" "$sauvegarde"
    echo "  mis de côté    $sauvegarde"
  fi
  ln -s "$source" "$cible"
  echo "  relié          $cible → $source"
}

echo "Effet CRT de VS Code"
# Ce chemin est celui que lit `vscode_custom_css.imports` dans les réglages
# synchronisés : il est le même sur macOS et sur Linux (Omarchy).
relier vscode/crt.css "$HOME/.local/share/omarchy-crt/vscode/crt.css"

cat <<'FIN'

Reste à faire dans VS Code, une fois par machine puis après chaque mise à jour
de VS Code (elle efface le correctif) :
  Palette (Cmd/Ctrl+Maj+P) → « Enable Custom CSS and JS », puis redémarrer.
Après une modification de crt.css : « Reload Custom CSS and JS ».
FIN
