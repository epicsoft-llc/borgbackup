# AGENTS.md

Guidance for AI coding agents and contributors working in this repository.

## What this repository is

There is no application source here. The repo produces the `epicsoft/borgbackup` Docker
image: [BorgBackup](https://borgbackup.readthedocs.io/) from the Alpine Linux packages,
on the official `alpine` image. Everything is one Dockerfile and a GitLab CI pipeline;
`README.md` is the published Docker Hub description and is uploaded by the pipeline, so
it is part of the release artifact, not just documentation.

| | |
|---|---|
| **Repository** | developed on `gitlab.com/epicsoft-networks/borgbackup` (branch `master`), mirrored to `github.com/epicsoft-llc/borgbackup` |
| **Registries** | `registry.gitlab.com/epicsoft-networks/borgbackup` and Docker Hub `epicsoft/borgbackup` |
| **Platforms** | `linux/amd64` and `linux/arm64` |

`ALPINE_VERSION` selects the base image (`alpine:<version>`), `IMAGE_TAG` only fills the
version label. The image runs `borg` as entrypoint; the BorgBackup version is the one
the Alpine release ships.

## Tags

| Tags | Built from | Content |
|---|---|---|
| `latest` | branch `master`, rebuilt weekly | `alpine:latest` with the newest packages |
| `edge` | branch `master`, rebuilt weekly | `alpine:edge` — newest BorgBackup, not for production |
| `stable`, `3.24` | branch `master`, rebuilt weekly | `alpine:3.24` (`STABLE_VERSION`) |
| `X.Y.Z`, `X.Y`, `X` | a git tag `X.Y.Z` | built on `STABLE_VERSION`, frozen at release time — the only tags a deployment should pin |

A release does **not** move `latest`: that tag keeps its meaning, the weekly build on
`alpine:latest`. Versioning follows Semantic Versioning, the rules are at the top of
`CHANGELOG.md`.

## Pipeline structure (`.gitlab-ci.yml`)

| Job | Trigger | Action |
|---|---|---|
| `latest`, `edge`, `stable` | branch `master` (push, weekly schedule) | build and test the runner's platform, then build both platforms and push to both registries |
| `release` | tag `X.Y.Z` | fails unless `CHANGELOG.md` has `## [X.Y.Z] - <date>`; same build on `STABLE_VERSION`, pushes `X.Y.Z`, `X.Y` and `X` to both registries |
| `uploadReadme` | branch `master` | README as Docker Hub description, at most 25,000 characters |
| `github-release` | tag `X.Y.Z`, after `release` | waits for the tag on GitHub, creates the release from the `CHANGELOG.md` entry |

The test (`borg --version`) runs **before** the push — a broken image never reaches a
registry. A multi-platform build cannot be loaded locally, so the runner's own platform
is built and tested first; the push build reuses those layers from the builder cache.
The `docker:dind` service runs with TLS, which buildx only takes from a Docker context —
hence `docker context create dind` before `docker buildx create`. Building
`linux/arm64` on an `amd64` runner needs QEMU (`binfmt_misc`) on the runner host.

CI variables: `DOCKER_HUB_USER`, `DOCKER_HUB_TOKEN`, `GITHUB_TOKEN` (masked, protected —
so the tags must be protected (`*.*.*`) or the jobs see no token).

**GitHub mirror:** a push mirror in the GitLab project settings (Repository → Mirroring
repositories) with its own token — not part of the pipeline. `GITHUB_TOKEN` is only for
`github-release`, which waits until the mirror has pushed the tag. Changes are never
pushed to GitHub directly; the mirror would overwrite them.

## Release checklist

- `CHANGELOG.md`: `## [X.Y.Z] - <date>` — the tag jobs fail without it, `github-release`
  takes the notes from exactly that heading
- The entry names the contained versions under `### Contents` — BorgBackup, Python and
  Alpine of the stable line, read from the current weekly image right before tagging:
  `docker run --rm --entrypoint sh epicsoft/borgbackup:stable -c 'cat /etc/alpine-release; borg --version; python3 --version'`
- `README.md`: the `## Versions` section, if versions changed, and on a new minor or major
  version the `X.Y` in the examples
- Tag on `master`, **without `v`**: `X.Y.Z`

### A new Alpine line

Raise `STABLE_VERSION` in `.gitlab-ci.yml` and the versions in `README.md`. The previous
line's tag (e.g. `3.24`) is no longer rebuilt from then on; list it under "no longer built".

## Local build / test commands

```bash
docker build --pull --no-cache -t borgbackup:local --build-arg ALPINE_VERSION=3.24 .
docker run --rm borgbackup:local --version
```

## Conventions

- `.editorconfig`: 2-space indent, LF, UTF-8, final newline, trailing whitespace
  trimmed (except Markdown), 120 cols (180 for YAML, off for Markdown);
  `.gitattributes` keeps LF in the repository.
- Commit messages use `feat:` / `fix:` / `ci:` / `chore:` prefixes.
- Dockerfile style: one `RUN` per concern, packages one per line with `\`
  continuations, upstream reference URLs as `####` comments above the block.
- `apk --no-cache upgrade` comes before `apk add`: `apk add` never upgrades the packages
  of the base image, so their security fixes would only arrive with the next base image.
- `CHANGELOG.md`: an entry goes under the version of its release tag.
