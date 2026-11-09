---
name: review
description: Reviewing a pull request, verifying its account against the issue, the design and the diff instead of trusting it. Read it before reviewing any pull request
---

# Reviewing a pull request

The pull request's body is the author's account of the change: a claim to
verify, not a summary to trust. Challenge the design as well as the code.

## One complete pass

Before writing a finding, take in the whole change: the issue and every comment
on it, the design it links, the body, the full diff, the code paths and tests it
touches, and the constraints that apply. Don't stop at the first finding. Report
everything you can reasonably find in one review, not one finding per round.
This is a best effort, not a promise of complete coverage, and it needs no
second reviewer or repeated pass.

On a revision, check that each earlier finding is fixed, then read the revised
diff for regressions and for what it newly exposes.

## The order

1. Read the issue, every comment on it and the design it links, and list the
   acceptance criteria and decisions yourself before reading the body. A later
   comment overrides earlier text.
2. Read the diff and map it to that list yourself.
3. Compare your map with the body's. A criterion it maps to code that doesn't
   do it is a finding. So is an omission, and a departure or added behaviour it
   says "none" to.
4. Check every constraint the issue's comments added, since those are what an
   account most often leaves out.
5. Ask of each new type, branch or state: what can be deleted, and what would be
   impossible without it? Ask it even where the change follows the design
   exactly. **An invariant the change leaves unguarded is a finding.**

## Departures

The body opens with its departures from the issue or the design. Judge each:
one that is simpler and still delivers what was approved is not a finding, and
needs no owner approval. One that loses part of the approved outcome is a
finding. Something the design asked for that the change lacks and the
departures don't name is an omission, not a simplification.

Most departures are settled in ordinary review. Say in the finding that the
owner must decide before merge only when a departure gives up a core
requirement, a security boundary or intended product behaviour.

## Findings

**A finding asks for what the issue requires, never more.** Proposing a
deletion stays within that limit; asking for something the issue didn't want
does not.

A misleading account is a finding about the pull request's body, however good
the code is.

Findings are the review's ordinary output. This skill adds no outcome, state or
step to it.
