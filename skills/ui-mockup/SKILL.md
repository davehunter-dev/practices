---
name: ui-mockup
description: Designing or building UI, deciding whether it needs an approved mockup first, making that mockup, and keeping it apart from evidence of what was built. Read it before designing, changing or building a screen
---

# Significant UI: the mockup

The owner clicking through a screen sees in a minute what a reviewer reading
code can't: a setting owned by the wrong object, a view reached the wrong way.
So the interaction model of significant UI is approved as a mockup before
production code exists, and the code is built from what was approved.

This skill says when a mockup is needed, what it must show, and what counts as
approval. A repository's `AGENTS.md` can exempt itself, or name its own host or
gate, and that wins. Nothing here requires a particular host, tool or
document format.

## Is it significant?

**Significant:** a new or changed screen or sheet, how one is reached or left,
how information is grouped or where it lives, which object owns a setting or a
control, or the states a view moves through.

**Trivial:** copy, colour, spacing or type inside an existing layout, an
accessibility label, a bug fix that restores what an approved design already
shows. Trivial work needs no mockup.

**Unclear means significant.** A mockup costs a design pass; building the wrong
model costs the implementation.

## The mockup

An interactive HTML page in the design pull request, beside the document that
links it. It shows the layout, the navigation, the states that matter and the
core interactions, and makes the model visible: what owns what. A screenshot, a
prose description, or a mockup drawn after the code doesn't count. Keep it one
self-contained page, so it opens from a file as well as from a host.

## The link

The owner opens it from the pull request in one click, on a host that limits it
to the team. Where the repository has no such host, the pull request says how to
open the page, and setting one up is a task of its own that the mockup doesn't
wait for. Never publish it openly to get the click. Vercel with Deployment
Protection is preferred for a repository already on Vercel, and isn't imposed
elsewhere.

## Approval

Approval is the owner's approval of that design pull request, recorded by its
merge. Nothing else counts: not a comment, not a reviewer's clean pass. A task
that builds the UI links the merged mockup.

Work with no approved mockup behind it, or whose building shows the approved
model is wrong, waits for one. It isn't reconciled in code. A mockup the owner
rejects in substance is revised on the same pull request and approved again.

## Two kinds of evidence, never mixed

A mockup is a proposal, under the design's name, drawn before the code. A
capture of the running app, or a preview deployment of it, is evidence of what
was built. Label it with the build's commit, and never let it stand in for a
mockup.
