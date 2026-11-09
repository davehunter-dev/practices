# Core practices

## Precedence

Where layers differ, the later one wins: this file, then the repository's
`AGENTS.md` and the documents it links, then the approved issue, its body and
the owner's comments, which may authorize a narrower exception for that work.
No layer weakens a check to get a change merged: linting, warnings as errors,
validation, or a meaningful test. Removing one is its own approved change.

## Build less

- **Does it need to exist?** Reuse the codebase, then the standard library, then
  a dependency already installed, before writing something new.
- **A new abstraction needs a required scenario:** the capability that is
  impossible without it. "This could happen" is not one.
- **The issue defines the supported state space.** Malformed, legacy, partially
  known, externally authored and hypothetical states are not requirements. At a
  boundary, reject an unsupported state or assert the invariant it violates. A
  product decision goes to the owner, not into code. Keep three distinctions:
  - Expected product states deserve modelling; failure states usually don't.
  - Data that needs only opaque round-trip stays at the persistence boundary.
  - A core invariant isn't weakened for exceptional input.
- **Observe before supporting.** Reject an unsupported case worth learning
  about with a useful diagnostic. Don't add recovery, compatibility or
  persistence machinery for it in advance.
- **Never cut:** validation at trust boundaries, protection against data loss,
  security, and accessibility.

Ask of every new abstraction, branch or state: what can be deleted, which
unrequested cases does it support, and what would be impossible without it?
The reuse ladder and the never-cut list are adapted from
[Ponytail](https://github.com/DietrichGebert/ponytail) (MIT).

## Challenge complexity, including in an approved design

Build something simpler when it keeps the approved behaviour. A change to an
approved decision, its scope or its architecture is never made silently: list
it in the pull request as a departure, or ask the owner first when it needs
their decision.

## Tests and checks

New behaviour needs a test that would fail without it. A warning is fixed, not
suppressed, and no check is weakened to merge.

## Leave touched areas simpler

- In an area you're changing, delete dead code, simplify, improve names and
  remove stale comments, without changing behaviour; a cleanup that needs a
  decision is its own issue. Deletion is a positive outcome: new complexity
  needs a reason, and removing accidental complexity doesn't.
- Prefer self-documenting code. Comment only what code can't say: a surprising
  choice, an external constraint, an invariant, a hazard. Keep it short.
- **Numbers have names.** A literal other than 0, 1 or an index is a named
  constant near the code that owns it, or an option if callers may tune it.
- **One representation per thing per layer.** Before adding a type for
  something already represented, list the existing representations and name the
  responsibility none of them can take. A difference only in encoding is a
  conversion at the boundary, not a new type.
- **State says its threading contract where it is declared:** which threads
  touch it and what protects it.

## Technology defaults

For a new repository, or a new component where `AGENTS.md` doesn't decide:
- **Web:** Next.js and TypeScript.
- **Native iOS and macOS:** Swift, with SwiftUI.
- **Portable components shared across platforms:** C++, owning the model and
  rules, with each platform's UI a thin layer over it.
- **Tooling:** the language the area already uses. No new language without the
  owner's approval in the design.

Existing code follows its established architecture, and a default never
authorizes a rewrite. A repository that wants to move says so in `AGENTS.md`.

## Significant UI

Significant UI is approved as a mockup before it is built, as the `ui-mockup`
skill describes, unless `AGENTS.md` exempts it.

## Communication

- Write for decisions, not completeness. Give the reader what they need to
  understand, decide, implement or verify, and cut any sentence that helps none
  of those. Don't show the work, and don't imitate existing verbosity.
- A long artifact, and every review, opens with a TLDR: what, why, and the
  decision or consequence, hiding no concern.
- Commits and pull request bodies are plain prose: what was wrong and why this
  shape is right. The diff already says what changed.
- Write for the owner's time. Say the thing, give the reason, and stop. Cut
  restatement, not substance: a question the owner has to ask back costs more
  than the sentence that would have answered it.
- No AI attribution in commits, pull requests or issues: no assistant
  authorship, "generated with" text, or co-author trailer.
