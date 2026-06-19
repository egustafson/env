# jfrog_cli

Installs the [JFrog CLI](https://docs.jfrog-applications.jfrog.io/jfrog-applications/jfrog-cli) (`jf`) on Linux hosts and optionally configures a connection to an Artifactory server.

## Requirements

- Ansible 2.12 or later
- Target hosts running a supported Linux distribution (see [Platforms](#platforms))
- `become: true` (root privileges required for package/binary installation)

## Platforms

| Family | Distributions |
|--------|--------------|
| Debian | Ubuntu 20.04, 22.04, 24.04 · Debian 11, 12 |
| RedHat | RHEL / CentOS / AlmaLinux / Rocky 8, 9 |
| Other  | Any Linux — automatic fallback to binary install |

## Role Variables

All variables have defaults defined in `defaults/main.yml`.

### Installation

| Variable | Default | Description |
|----------|---------|-------------|
| `jfrog_cli_install_method` | `"package"` | `"package"` uses the OS package manager; `"binary"` downloads the binary directly. |
| `jfrog_cli_version` | `"latest"` | Version to download. Used only when `install_method` is `"binary"`. Accepts a version string (e.g. `"2.67.0"`) or `"latest"`. |
| `jfrog_cli_install_dir` | `"/usr/local/bin"` | Destination directory for the binary. Used only when `install_method` is `"binary"`. |

### Server Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `jfrog_cli_configure` | `false` | When `true`, runs `jf c add` after installation to register an Artifactory server. |
| `jfrog_cli_server_id` | `"artifactory"` | Alias used by the CLI to identify this server. |
| `jfrog_cli_url` | `""` | Artifactory base URL, e.g. `https://mycompany.jfrog.io/artifactory`. Required when `jfrog_cli_configure: true`. |
| `jfrog_cli_access_token` | `""` | Access token for authentication. Takes precedence over user/password when set. |
| `jfrog_cli_user` | `""` | Username for authentication. Used when `access_token` is empty. |
| `jfrog_cli_password` | `""` | Password for authentication. Used together with `user`. |

Either `jfrog_cli_access_token` **or** both `jfrog_cli_user` and `jfrog_cli_password` must be provided when `jfrog_cli_configure: true`.

## Dependencies

None.

## Example Playbook

### Install only (package manager, default)

```yaml
- name: Install JFrog CLI
  hosts: all
  become: true
  roles:
    - role: jfrog_cli
```

### Install via binary download and pin a version

```yaml
- name: Install JFrog CLI (pinned binary)
  hosts: all
  become: true
  roles:
    - role: jfrog_cli
      vars:
        jfrog_cli_install_method: binary
        jfrog_cli_version: "2.67.0"
```

### Install and configure an Artifactory server (access token)

```yaml
- name: Install and configure JFrog CLI
  hosts: all
  become: true
  roles:
    - role: jfrog_cli
      vars:
        jfrog_cli_configure: true
        jfrog_cli_url: "https://mycompany.jfrog.io/artifactory"
        jfrog_cli_server_id: "mycompany"
        jfrog_cli_access_token: "{{ lookup('env', 'JFROG_ACCESS_TOKEN') }}"
```

### Install and configure with username and password

```yaml
- name: Install and configure JFrog CLI
  hosts: all
  become: true
  roles:
    - role: jfrog_cli
      vars:
        jfrog_cli_configure: true
        jfrog_cli_url: "https://mycompany.jfrog.io/artifactory"
        jfrog_cli_user: "myuser"
        jfrog_cli_password: "{{ vault_jfrog_password }}"
```

## Task Flow

```
tasks/main.yml
├── install_apt.yml      (Debian/Ubuntu, package method)
│   ├── Install prerequisites (curl, gnupg, apt-transport-https)
│   ├── Download and dearmor JFrog GPG key
│   ├── Add JFrog apt repository
│   └── Install jfrog-cli-v2-jf
├── install_yum.yml      (RedHat family, package method)
│   ├── Add JFrog yum repository
│   └── Install jfrog-cli-v2-jf
├── install_binary.yml   (any OS, binary method or non-Debian/RedHat fallback)
│   ├── Detect CPU architecture (amd64 / arm64 / arm)
│   ├── Resolve version (GitHub API or pinned)
│   └── Download jf binary to jfrog_cli_install_dir
├── Verify installation  (jf --version)
└── configure.yml        (when jfrog_cli_configure: true)
    ├── Validate required variables
    ├── jf c add … --access-token  (when access_token set)
    └── jf c add … --user/--password  (fallback)
```

## Security Notes

- Credential tasks use `no_log: true` — tokens and passwords are never written to Ansible output or logs.
- It is strongly recommended to supply `jfrog_cli_access_token` via an environment variable or Ansible Vault rather than in plain-text inventory.
- The JFrog RPM repository does not publish a GPG key; `gpgcheck` is intentionally disabled for that repo only.

## License

Apache-2.0
