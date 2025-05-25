# Simple BorgBackup Docker Image

This Docker image is managed and kept up to date by [epicsoft LLC](https://epicsoft.one).

A simple Docker image with [BorgBackup](https://borgbackup.readthedocs.io/) and based on official [Alpine image](https://hub.docker.com/_/alpine).

* Base image: https://hub.docker.com/_/alpine
* Dockerfile: https://gitlab.com/epicsoft-networks/zitadel-tools/blob/main/Dockerfile
* Repository: https://gitlab.com/epicsoft-networks/zitadel-tools/tree/main
* Container-Registry: https://gitlab.com/epicsoft-networks/zitadel-tools/container_registry
* Docker Hub: https://hub.docker.com/r/epicsoft/zitadel-tools

## Versions

Versioning uses the Alpine version number, which is also the base image.

If you need a different version, you may copy and modify my templates as needed.

###  1.1. <a name='Details'></a>Details

`edge`

- Use the `edge` official [Alpine Linux](https://hub.docker.com/_/alpine/) Docker image as base image
- Installs the current [BorgBackup](https://borgbackup.readthedocs.io/) version from the [Alpine Linux packages](https://pkgs.alpinelinux.org/) depending on the Apline Linux

`latest`

- Use the `latest` official [Alpine Linux](https://hub.docker.com/_/alpine/) Docker image as base image
- Installs the current [BorgBackup](https://borgbackup.readthedocs.io/) version from the [Alpine Linux packages](https://pkgs.alpinelinux.org/) depending on the Apline Linux

`3.21` `stable`

- Use the `3.21` official [Alpine Linux](https://hub.docker.com/_/alpine/) Docker image as base image
- Installs the current [BorgBackup](https://borgbackup.readthedocs.io/) version from the [Alpine Linux packages](https://pkgs.alpinelinux.org/) depending on the Apline Linux

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
docker run --rm registry.gitlab.com/epicdocker/borgbackup:latest
```

```bash
> borgbackup version 1.4.0
> usage: borg [-V] [-h] [--critical] [--error] [--warning] [--info] [--debug]
> ...
```


### Initialize a repository

After entering the password, the repository is created in the `/target` directory.

```bash
docker run --rm -it --name borg \
  -v /tmp/backup/target:/target \
  -v /tmp/backup/source:/source:ro \
  registry.gitlab.com/epicdocker/borgbackup:latest \
  init --encryption=repokey /target
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
  -v /tep/backup/source:/source:ro \
  registry.gitlab.com/epicdocker/borgbackup:latest \
  create /target::archiveName /source --stats
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
  registry.gitlab.com/epicdocker/borgbackup:latest \
  list /target
```

```bash
> Monday                               Wed, 2018-05-23 18:12:30 [09206c98a0d86435169e8d2c6ab40965971dd466998537b12d75b19c455394b1]
> archiveName                          Wed, 2018-05-23 18:14:52 [db079cc945a5c0f9ae874ee5705f5754298cd024443fdee790dc7cf9b92cae27]
```

## License

MIT License see [LICENSE](https://gitlab.com/epicdocker/borgbackup/blob/master/LICENSE)

Please note that the MIT license only applies to the files created by epicsoft LLC. Other software may be licensed under other licenses.
