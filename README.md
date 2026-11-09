# practices

One person's opinionated way of building software, as plain Markdown any agent
can read: `core.md`, always on, and skills under `skills/<name>/SKILL.md`, each
read before doing its activity. It names no project, and is not specific to one
agent.

**It is optional for everyone,** including Tickwork's users. Nothing requires
it: a repository opts in by committing the two files below, and drops it by
deleting them. Read `core.md` before opting in; it is the whole of what a
session is told.

## What loading does

Each session fetches this repository's `main` into a bare clone under
`${XDG_CACHE_HOME:-$HOME/.cache}/practices`, and runs that revision's `load.sh`.
`load.sh` extracts the revision's files into the cache and prints a header
naming the commit, `core.md`, and the skills by path. It changes nothing
outside the cache and runs nothing else. If the fetch fails, the session uses
the last fetched `main` and says so.

The loader fetches `+main:main`, so it follows `main` even if it is replaced
rather than fast-forwarded. Opting in means running whatever `main` holds at
each session, so to pin a version, point the loader at your own fork.

## Opting a repository in

Commit two files.

**`.agents/practices.sh`:**

    set -eu
    cache=${XDG_CACHE_HOME:-$HOME/.cache}/practices
    [ -d "$cache/repo.git" ] || git clone -q --bare https://github.com/davehunter-dev/practices.git "$cache/repo.git"
    git -C "$cache/repo.git" fetch -q origin +main:main || echo "practices: fetch failed, using the last fetched main" >&2
    load=$(git -C "$cache/repo.git" show main:load.sh)
    sh -c "$load" load.sh "$cache"

**The first line of `AGENTS.md`:**

> Before other work in a session, run `sh .agents/practices.sh` and follow what
> it prints. Where they differ, this file wins over it, and an approved issue
> wins over both, except that no layer weakens a check to merge. If it fails,
> report why and stop.

A headless agent needs permission to run `sh .agents/practices.sh`.

## Changing it

`core.md` is loaded into every session of every repository that opts in, so a
pull request that grows it says what it displaces. Anything needed only during
one activity belongs in that activity's skill.

## License

MIT, in `LICENSE`. `NOTICE` credits the material `core.md` adapts from
Ponytail.
