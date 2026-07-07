# Concept

When landing on a new machine (vm) with none of your customized environment
settings, pull this git repo and use the contents to 'deploy' your environment
into your new account.

## Prerequisites

- `git`
- `python3`
- `ansible` (for provisioning; see [Ansible](#ansible) below)
- `pass` (the Unix password manager; required for secret-backed shell features)

## Bootstrap

Clone the repo into `~/env`, then run the installer from your home directory:

```
cd ~
git clone git@github.com:egustafson/env.git env
python env/install.py
```

`install.py` creates symlinks in `$HOME` for each managed directory:

| Source | Symlinked as |
|---|---|
| `rc/*` | `~/.<name>` (e.g. `rc/bashrc` → `~/.bashrc`) |
| `ssh/*` | `~/.ssh/<name>` |
| `gnupg/*` | `~/.gnupg/<name>` |
| `config/*` | `~/.config/<name>` |
| `bin/*` | `~/bin/<name>` |

Any existing file at the target path is replaced. A `.ignore` file inside a
source directory will cause listed files to be skipped (e.g. `README.md` files
are excluded from `ssh/`).

After symlinking, the installer runs an Emacs batch bootstrap
(`initialize-emacs.el`) to install the ELPA keyring and load `init.el` for
first-time package installation.

## Ansible

The `ansible/` directory contains playbooks and roles to provision a machine
from scratch.

### Playbooks

| Playbook | Purpose |
|---|---|
| `ericg.yml` | Personal environment: apt packages, env repo clone, `install.py` |
| `tools.yml` | Dev tool roles (see role list below) |
| `make-ericg.yml` | Create the `ericg` sudo user on a fresh host |
| `make-egustafson.yml` | Create the `egustafson` sudo user on a fresh host |
| `golang.yml` | Standalone Go toolchain upgrade-to-latest |
| `ericg-am.yml` | Configure autofs home directory mount |

### Inventories

- `localhost.ini` — run against the local machine (`ansible_connection=local`)
- `remotehost.ini` — run against a remote host (copy from `remotehost.ini.example`)

### Running

```
# Provision local environment
ansible-playbook -i ansible/localhost.ini ansible/ericg.yml

# Install all dev tools
ansible-playbook -i ansible/localhost.ini ansible/tools.yml

# Install a single tool by tag
ansible-playbook -i ansible/localhost.ini ansible/tools.yml --tags github_cli
```

### Roles (`tools.yml`)

| Role | Tag | Description |
|---|---|---|
| `ansible` | `ansible` | Install Ansible itself |
| `kube` | `kube` | kubectl, kind, stern |
| `docker` | `docker` | Docker CE (daemon + CLI) |
| `dockercli` | `dockercli` | Docker CLI only |
| `etcdctl` | `etcdctl` | etcd client binary |
| `vicecli` | `vicecli` | Viasat VICE CLI |
| `grip` | `grip` | GitHub Markdown previewer |
| `github_cli` | `github_cli` | GitHub CLI (`gh`) |
| `uv` | `uv` | Python package/project manager |
| `golang` | `golang` | Go toolchain |
| `gcloud_sdk` | `gcloud` | Google Cloud SDK |
| `awscli` | `awscli` | AWS CLI v2 |
| `terraform` | `terraform` | Terraform |
| `alohomora` | `alohomora` | Viasat SAML → AWS credentials tool |
| `jfrog_cli` | `jfrog` | JFrog CLI (`jf`) |
| `opencode` | `opencode` | opencode AI coding agent |

## Shell Configuration

### rc

The `rc/` directory contains dotfiles symlinked into `$HOME` as hidden files.
The main shell configs are `bashrc` (Bash) and `cshrc` (tcsh), both of which
support multi-OS environments (Linux, macOS, Cygwin, WSL).

### bashrc-local hook system

Per-machine customization is done via `~/.bashrc-local`. Use the template at
`rc/bashrc-local-template` as a starting point. Two hooks are available:

- **prehook** — sourced before the main `.bashrc` body
- **posthook** — sourced after the main `.bashrc` body

### bashrc.d modules

Numbered modules in `~/.bashrc.d/` are auto-loaded by `.bashrc` in sort order.
Modules in this repo:

| Module | Purpose |
|---|---|
| `lib.bashrc` | `setpath`, `lspath`, `reload` helper functions |
| `50-clean-tmp.bashrc` | Clean stale user-owned `/tmp` entries (WSL-targeted) |
| `51-wsl-distro.bashrc` | WSL distro detection, PS1, `code`/`brave` aliases |
| `52-kube-helpers.bashrc` | `kc` alias for kubeconfig context switching |
| `53-docker-tweaks.bashrc` | Disable `DOCKER_BUILDKIT` when Podman is detected |
| `60-flutter-dev.bashrc` | Flutter/Android/Dart paths |
| `70-elfwerks-ai.bashrc` | opencode + OpenRouter API keys via `pass` |
| `80-aws-elfwerks.bashrc` | AWS credentials via `pass` |
| `90-viasat-dev.bashrc` | Viasat dev environment variables |
| `95-viasat-claude.bashrc` | Viasat Claude/Jira/Confluence tokens, nvm |

### Feature flags

Several modules are opt-in via environment variables set in `~/.bashrc-local`:

| Variable | Module | Effect |
|---|---|---|
| `ENABLE_ELFHOST=YES` | `70-elfwerks-ai.bashrc` | opencode path + OpenRouter API keys |
| `ENABLE_ELF_AWS=YES` | `80-aws-elfwerks.bashrc` | AWS credentials from `pass` |
| `ENABLE_FLUTTER=YES` | `60-flutter-dev.bashrc` | Flutter/Android/Dart dev paths |
| `VIALAP=YES` | `90-viasat-dev.bashrc` | Viasat dev environment |

## bin

Custom scripts deployed to `~/bin`. Highlights:

- `em`, `client_emacs.sh` — Emacs launcher and emacsclient wrapper
- `kc.bash` / `kc.csh` — kubeconfig context switcher (Bash and tcsh)
- `merge-ssh-config.pl` — merge SSH config fragments with `config.local`
- `jsonpretty` — pretty-print JSON from stdin
- `nuke-docker` — force-remove all Docker containers
- `lxc-bulk` — bulk start/stop/clone/destroy LXC containers
- `secrets`, `use_aws` — AWS credential helpers (via `pass`)

## ssh

SSH client config and public keys are deployed to `~/.ssh` by `install.py`.
The `ssh/config` file includes pre-configured host blocks for Elfwerks homelab,
GitHub, local/VirtualBox networks, and Viasat.

### Bootstrap (GPG-encrypted archive)

On a fresh machine before SSH keys are available, restore from the encrypted
bootstrap archive:

```
cd ~
gpg env/ssh/ssh-bootstrap.tgz.asc
tar -xvzf ssh-bootstrap.tgz
ln -s ssh-bootstrap .ssh
git clone git-repository:ssh.git ssh
ln -sf ssh .ssh
rm -rf ssh-bootstrap*
```

## WSL / Windows

### WSL2

`WSL/wsl.conf` configures WSL2:
- Enables systemd
- Sets default user to `egustafson`
- Disables automatic Windows `$PATH` appending

Copy to `/etc/wsl.conf` inside the WSL distro.

### wsltty theme

`WSL/solarized-dark.minttyrc` is the wsltty Solarized Dark color theme.
Copy to `%APPDATA%\wsltty\themes\` on Windows.

### Windows SSH config

`windows_rc/ssh/config` is an SSH config template for VSCode Remote-SSH on
Windows. Copy to `%USERPROFILE%\.ssh\config`.

## tools

`tools/` contains legacy one-shot shell scripts for system-level setup
(Ansible, Docker CE, Google Cloud SDK). These pre-date the Ansible roles and
are largely superseded by them, but are kept as a reference.

## git-subrepo

The `git-subrepo` tool is vendored in `git-subrepo/` as a subrepo of itself.
Both `.bashrc` and `.cshrc` add `git-subrepo/lib` to `$PATH`, making
`git subrepo` available automatically after running `install.py`.
