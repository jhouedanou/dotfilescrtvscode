# dotfiles

Fichiers de configuration que la synchronisation des réglages de VS Code ne transporte pas.

## Effet CRT de VS Code

`vscode/crt.css` ajoute à VS Code un halo phosphore sur le texte, des lignes de balayage, une vignette et un léger scintillement. Le scintillement est coupé quand « Réduire les animations » est actif. La feuille passe par l'extension **Custom CSS and JS Loader** (`be5invis.vscode-custom-css`).

La synchronisation des réglages transporte l'extension et le réglage `vscode_custom_css.imports`, mais pas ce fichier. Le réglage pointe vers ce chemin, sur macOS comme sur Linux :

```
~/.local/share/omarchy-crt/vscode/crt.css
```

### Sur une nouvelle machine

```sh
git clone <adresse du dépôt> ~/Documents/GitHub/dotfiles
~/Documents/GitHub/dotfiles/installer.sh
```

Ensuite, dans VS Code : Palette → **Enable Custom CSS and JS**, puis redémarrer. VS Code peut alors dire que l'installation est « corrompue ». C'est attendu avec cette extension : choisir « Ne plus afficher ».

### Au quotidien

- **Modifier l'effet :** éditer `vscode/crt.css` dans ce dépôt, puis Palette → **Reload Custom CSS and JS**. Commiter et pousser pour que les autres machines le reçoivent avec un `git pull`.
- **Après une mise à jour de VS Code :** relancer **Enable Custom CSS and JS**. La mise à jour efface le correctif.
- **Régler l'intensité :** les variables `--crt-glow`, `--crt-scanline` et `--crt-vignette` en tête du fichier.
