# BorgBackup

This Docker image is managed and kept up to date by [epicsoft LLC](https://epicsoft.one).

[BorgBackup](https://borgbackup.readthedocs.io/) for deduplicated, encrypted backups, installed from the
[Alpine Linux packages](https://pkgs.alpinelinux.org/) on the official [Alpine image](https://hub.docker.com/_/alpine).

* Base image: https://hub.docker.com/_/alpine, platforms `linux/amd64` and `linux/arm64`
* Dockerfile: https://gitlab.com/epicsoft-networks/borgbackup/-/blob/master/Dockerfile
* Repository: https://gitlab.com/epicsoft-networks/borgbackup, mirrored to [GitHub](https://github.com/epicsoft-llc/borgbackup) — issues are welcome on both; code changes only as merge requests on GitLab, the mirror overwrites anything pushed to GitHub
* Container registry: https://gitlab.com/epicsoft-networks/borgbackup/container_registry
* Docker Hub: https://hub.docker.com/r/epicsoft/borgbackup
* Changelog: https://gitlab.com/epicsoft-networks/borgbackup/-/blob/master/CHANGELOG.md
* License: MIT

## Versions

Released through a git tag `X.Y.Z`, which publishes `X.Y.Z`, `X.Y` and `X` on the stable Alpine line. Changes and the
contained versions are listed in the [changelog](https://gitlab.com/epicsoft-networks/borgbackup/-/blob/master/CHANGELOG.md).

| Tag | Content |
|---|---|
| `1.0.1` | exactly this build - **use this in production** |
| `1.0`, `1` | newest release of that line |
| `stable`, `3.24` | rebuilt weekly on `alpine:3.24` |
| `latest` | rebuilt weekly on `alpine:latest` |
| `edge` | rebuilt weekly on `alpine:edge` - newest BorgBackup from Alpine edge, not for production |

`1.0.1` contains BorgBackup `1.4.4`, Python `3.14.8` and Alpine `3.24.2`. The BorgBackup version is the one the
Alpine release ships.

No longer built: `3.21` (Alpine `3.21`), `latest-arm` and `stable-arm` - `linux/arm64` is part of every tag.

## Additional Alpine packages

Alpine packages are installed in the current image in the latest version - https://pkgs.alpinelinux.org/packages
  - py3-packaging
  - libffi-dev
  - openssl-dev
  - ca-certificates

## Examples

### Start container

Displays the version and help from BorgBackup

```bash
docker run --rm epicsoft/borgbackup:1.0
```

```bash
> borgbackup version 1.4.4
> usage: borg [-V] [-h] [--critical] [--error] [--warning] [--info] [--debug]
> ...
```

### Initialize a repository

After entering the password, the repository is created in the `/target` directory.

```bash
docker run --rm -it --name borg \
  -v /tmp/backup/target:/target \
  -v /tmp/backup/source:/source:ro \
  epicsoft/borgbackup:1.0 init --encryption=repokey /target
```

```bash
> Enter new passphrase:
> ...
```

### Create a backup

Creates a backup using the passed password and displays the statistics

```bash
docker run --rm -it --name borg \
  -e BORG_PASSPHRASE=secret \
  -v /tmp/backup/target:/target \
  -v /tmp/backup/source:/source:ro \
  epicsoft/borgbackup:1.0 create /target::archiveName /source --stats
```

```bash
> ------------------------------------------------------------------------------
> Archive name: archiveName
> Archive fingerprint: db079cc945a5c0f9ae874ee5705f5754298cd024443fdee790dc7cf9b92cae27
> ...
```

### Show backups

Show all backups as a list. This example displays an additional backup.

```bash
docker run --rm -it --name borg \
  -e BORG_PASSPHRASE=secret \
  -v /tmp/backup/target:/target \
  -v /tmp/backup/source:/source:ro \
  epicsoft/borgbackup:1.0 list /target
```

```bash
> Monday                               Wed, 2018-05-23 18:12:30 [09206c98a0d86435169e8d2c6ab40965971dd466998537b12d75b19c455394b1]
> archiveName                          Wed, 2018-05-23 18:14:52 [db079cc945a5c0f9ae874ee5705f5754298cd024443fdee790dc7cf9b92cae27]
```

## Reporting problems

Issues are welcome on [GitLab](https://gitlab.com/epicsoft-networks/borgbackup/-/issues) and
[GitHub](https://github.com/epicsoft-llc/borgbackup/issues). Please report a security problem as a
**confidential issue** on GitLab instead of a public one.

## License

[MIT](https://gitlab.com/epicsoft-networks/borgbackup/-/blob/master/LICENSE) — Copyright (c) 2022-2026 epicsoft LLC

The MIT license applies only to files created by epicsoft LLC. Third-party software in the image — BorgBackup
(BSD-3-Clause), Python, the Alpine packages and the official `alpine` image — remains under its own licenses.
