# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles for macOS (`darwin`), supporting both **Bash** and **Fish** shells. There is no build or test step — "installing" means symlinking config files into `$HOME` / `~/.config` and appending to shell rc files. The owner's daily driver is Fish; Bash config is the legacy/fallback path.

## Install commands (the Makefile is the entry point)

```bash
make            # lists all documented targets (default goal; targets are self-documenting via `## ` comments)
make install    # symlinks .gitconfig/.gitignore/.git-prompt, appends .bashrc (+ .bash_profile on macOS), installs container-structure-test
make install_bat # installs sharkdp/bat (Debian .deb — Linux only) and aliases `cat` to it
make install_fish # symlinks fish/ configs, installs Fisher + nvm.fish + Node 22
```

`make help` works by `fgrep`-ing `## ` comments out of the Makefile — when adding a target, append a `## description` on the target line to keep it discoverable.

## Architecture / structure to know

- **Two parallel shell worlds.** `.bashrc`/`.bash_profile`/`.git-prompt`/`.npm-prompt` configure Bash; `fish/` configures Fish. They intentionally mirror each other — e.g. `fish/functions/fish_prompt.fish` reimplements the same `HH:MM:SS[user]~/path(branch)$` prompt (green=clean, red=dirty) that `.git-prompt` builds for Bash via `PROMPT_COMMAND`. **A change to one shell's aliases/prompt usually needs the equivalent change in the other.**
- **Fish config is the source of truth for aliases.** `fish/config.fish` holds the real, current alias set (Nx/pnpm workflow aliases, project-navigation `cd` aliases, git-cleanup aliases). The Bash `.bashrc` alias set is much smaller and older. Interactive-only logic lives inside `if status is-interactive`; functions and PATH/env exports that must work in non-interactive shells (e.g. `make`, `jake`, bun PATH) live **outside** that block.
- **`fish/conf.d/00-nvm-config.fish`** is loaded before `nvm.fish` (numeric prefix ordering) and only sets `nvm_default_version 22`. Node is managed by nvm.fish via Fisher, not installed directly.
- **`make` is shadowed by a Fish function** in `config.fish` that walks up parent directories to find a `Makefile` — so `make` works from subdirectories. Keep this in mind: in Fish, `make` is not plain GNU make.
- **`.gitconfig` is heavily aliased and environment-scoped.** It contains many custom git aliases (worktree helpers `wta`/`wtr`/`wtl`/`wtpr`, `self` for interactive rebase onto the last non-fixup commit, `die` for a hard working-tree reset, `pushy`/`pusho`, GitLab MR push helpers `pushc`/`mwps`). Default branch is `main`; `pull.rebase`, `rebase.autosquash`, and `rebase.autostash` are on. `includeIf` blocks layer a separate work identity (`/Volumes/workspace/emeria/.gitconfig`) over any repo under the emeria/millenium paths — do not assume the global user identity applies inside those work repos.
- **`/Volumes/workspace`** is the assumed workspace root throughout (aliases, prompt path-shortening for `…/emeria/millenium`, the `jake` function pointing at `jake-emeria`). Paths are hardcoded to this machine's layout.

## Conventions

- Comments in shell/fish config are written in **French**; keep that convention when editing those files. Documentation and git-alias comments are in English.
- Commit messages follow Conventional Commits with a scope, e.g. `chore(fish): …`, `feat(fish): …`, `chore(gi): …` (gi = gitignore/gitconfig).
- The workflow is **pnpm + Nx**, not npm. `.npm-prompt` (Bash) loads nvm, adds npm + pnpm shell completion (`completion-for-pnpm.bash`), and defines `p` as a pnpm wrapper; the Fish side has the `lint`/`build`/`ts`/`nx_test`/`all` Nx aliases.
