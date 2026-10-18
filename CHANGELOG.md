# Changelog

All notable changes to this project are documented here.
The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
the versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

| Part | Raised when |
|---|---|
| **MAJOR** | existing commands or scripts can break — a new BorgBackup major line, a changed entrypoint, a removed package |
| **MINOR** | a package or a feature of the image is added, or the stable Alpine line moves on |
| **PATCH** | a rebuild with updated packages or a fix |

**A release is a git tag `X.Y.Z`.** CI builds `X.Y.Z`, `X.Y` and `X` from it on the stable Alpine line for
`linux/amd64` and `linux/arm64` and creates the GitHub release from the entry below; `latest` stays the weekly build
on `alpine:latest`. Each release entry names the contained versions: BorgBackup, Python and Alpine. The weekly builds
(`latest`, `edge`, `stable`) are not listed here.

## [1.0.0] - 2026-10-18

### Contents

- BorgBackup `1.4.4`, Python `3.14.8`, Alpine `3.24.2`

### Added

- Releases from git tags `X.Y.Z` with the image tags `X.Y.Z`, `X.Y` and `X`, built on the stable Alpine line, and a
  GitHub release from this changelog

### Changed

- `stable` is built together with `3.24` and published on Docker Hub as well - it was only re-tagged in the GitLab
  registry, so `epicsoft/borgbackup:stable` on Docker Hub still dated from 2025-05-25
- The pipeline tests each image (`borg --version`) before it pushes it, and buildx reaches the TLS-secured `docker:dind`
  through a Docker context
- Registry logins and the Docker Hub description upload take their tokens over stdin or the environment instead of the
  command line
- The base image is selected with the build argument `ALPINE_VERSION`; `IMAGE_TAG` only fills the version label.
  Maintainer address in the labels: `info@epicsoft.one`

### Fixed

- README links to the branch `main` - the branch is `master`
