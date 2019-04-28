<!-- vscode-markdown-toc -->
* 1. [Versions](#Versions)
	* 1.1. [Details](#Details)
* 2. [Examples](#Examples)
	* 2.1. [Start container](#Startcontainer)
	* 2.2. [Initialize a repository](#Initializearepository)
	* 2.3. [Create a backup](#Createabackup)
	* 2.4. [Show backups](#Showbackups)
* 3. [Links](#Links)
* 4. [License](#License)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->


# Simple BorgBackup Docker Image

A simple Docker image with [BorgBackup](https://borgbackup.readthedocs.io/) and [Alpine Linux](https://alpinelinux.org/) as base image.


##  1. <a name='Versions'></a>Versions

Versioning uses the Alpine version number, which is also the base image.

If you need a different version, you may copy and modify my templates as needed.


###  1.1. <a name='Details'></a>Details

`edge`

- Use the `edge` official [Alpine Linux](https://hub.docker.com/_/alpine/) Docker image as base image
- Installs the current [BorgBackup](https://borgbackup.readthedocs.io/) version from the [Alpine Linux packages](https://pkgs.alpinelinux.org/) depending on the Apline Linux

`3.9WA` _(with workaround)_ `latest`

- Use the `3.9` official [Alpine Linux](https://hub.docker.com/_/alpine/) Docker image as base image
- Installs the current [BorgBackup](https://borgbackup.readthedocs.io/) version from the [Alpine Linux packages](https://pkgs.alpinelinux.org/) depending on the Apline Linux
- Uses workaround to install `msgpack-python`

`3.9`

- Use the `3.9` official [Alpine Linux](https://hub.docker.com/_/alpine/) Docker image as base image
- Installs the current [BorgBackup](https://borgbackup.readthedocs.io/) version from the [Alpine Linux packages](https://pkgs.alpinelinux.org/) depending on the Apline Linux

`3.8` `stable`

- Use the `3.8` official [Alpine Linux](https://hub.docker.com/_/alpine/) Docker image as base image
- Installs the current [BorgBackup](https://borgbackup.readthedocs.io/) version from the [Alpine Linux packages](https://pkgs.alpinelinux.org/) depending on the Apline Linux

`3.7`

- Use the `3.7` official [Alpine Linux](https://hub.docker.com/_/alpine/) Docker image as base image
- Installs the current [BorgBackup](https://borgbackup.readthedocs.io/) version from the [Alpine Linux packages](https://pkgs.alpinelinux.org/) depending on the Apline Linux


##  2. <a name='Examples'></a>Examples 


###  2.1. <a name='Startcontainer'></a>Start container

Displays the version and help from BorgBackup

    docker run --rm --name borg registry.gitlab.com/epicdocker/borgbackup:stable
    
    > borgbackup version 1.1.3
    > usage: borg [-V] [-h] [--critical] [--error] [--warning] [--info] [--debug]
    > ...


###  2.2. <a name='Initializearepository'></a>Initialize a repository

After entering the password, the repository is created in the `/target` directory.

    docker run --rm -it --name borg \
      -v /tmp/backup/target:/target \
      -v /tmp/backup/source:/source:ro \
      registry.gitlab.com/epicdocker/borgbackup:stable \
      init --encryption=repokey /target

    > Enter new passphrase:
    > ...


###  2.3. <a name='Createabackup'></a>Create a backup

Creates a backup using the passed password and displays the statistics

    docker run --rm -it --name borg \
      -e BORG_PASSPHRASE=secret \
      -v /tmp/backup/target:/target \
      -v /tep/backup/source:/source:ro \
      registry.gitlab.com/epicdocker/borgbackup:stable \
      create /target::archiveName /source --stats

    > ------------------------------------------------------------------------------
    > Archive name: archiveName
    > Archive fingerprint: db079cc945a5c0f9ae874ee5705f5754298cd024443fdee790dc7cf9b92cae27
    > ...


###  2.4. <a name='Showbackups'></a>Show backups

Show all backups as a list. This example displays an additional backup.

    docker run --rm -it --name borg \
      -e BORG_PASSPHRASE=secret \
      -v /tmp/backup/target:/target \
      -v /tmp/backup/source:/source:ro \
      registry.gitlab.com/epicdocker/borgbackup:stable \
      list /target

    > Monday                               Wed, 2018-05-23 18:12:30 [09206c98a0d86435169e8d2c6ab40965971dd466998537b12d75b19c455394b1]
    > archiveName                          Wed, 2018-05-23 18:14:52 [db079cc945a5c0f9ae874ee5705f5754298cd024443fdee790dc7cf9b92cae27]


##  3. <a name='Links'></a>Links

- BorgBackup - https://borgbackup.readthedocs.io/
- SourceCode - https://gitlab.com/epicdocker/borgbackup/tree/master
- GitLab Registry - https://gitlab.com/epicdocker/borgbackup/container_registry


##  4. <a name='License'></a>License

MIT License see [LICENSE](https://gitlab.com/epicdocker/borgbackup/blob/master/LICENSE)
