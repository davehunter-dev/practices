---
name: post-pr
description: Preparing and submitting a pull request, checking the finished work against what was approved, and writing the body a reviewer checks. Read it before writing any pull request body
---

# Posting a pull request

## Check the work against what was approved

Reread the issue, every comment on it, and the design it links; a later comment
overrides earlier text. Check the finished change against each acceptance
criterion and each decision recorded there. A criterion with nothing to point
to is not done, so finish it before posting.

## Departures come first

The body opens with the meaningful departures from the issue or the design,
before any summary:

    Departures:
    - <what changed or was removed>: <why>. <what it costs>.

For each, say what changed or was removed, why, and what it affects:
behaviour, a guarantee, a tradeoff. Name a removed design element outright, so
a reviewer can't take it for an omission. A simplification that keeps the
approved behaviour needs no prior agreement, only disclosure here. A change that
needs the owner's decision follows `core.md` and the issue. With nothing to
disclose, write "Departures: none."

## The account

After the summary, one section maps the change to what was approved. A reviewer
checks it against the diff, so it is a claim to verify, not a summary. Every
line is a fact a reviewer can check, or "none". No line is left out.

    ## How this maps to #N
    - **Criteria:** …
    - **Not asked for, added anyway:** …
    - **Look hardest at:** …
    - **Verified:** …

- **Criteria:** each acceptance criterion, by the issue's numbering, mapped to
  its evidence: a file and function, a test by name, a screen's action, a
  command and its output.
- **Not asked for, added anyway:** any behaviour, type, option, state or cleanup
  the issue didn't ask for. The owner reads this line first, because it is where
  unrequested scope shows.
- **Look hardest at:** the one or two places where a mistake is likeliest or
  costliest, and what makes them so: a lock, an invariant, a boundary.
- **Verified:** what ran and its result, and what wasn't run and so is
  unchecked.

For example:

    Departures:
    - The design's undo per item is undo per list: items have no stable id,
      and giving them one is a migration the issue didn't ask for. Undo
      restores a whole list, so one item's edit can't be undone alone.

    Lists merge in place, so two edits to the same list no longer race.

    ## How this maps to #N
    - **Criteria:** 1 → `Store.merge`; 2 → the test "merge keeps order";
      3 → the list's delete action.
    - **Not asked for, added anyway:** none.
    - **Look hardest at:** `merge` holds the store's lock while it copies, and
      releases it before notifying.
    - **Verified:** the project's build and tests, green. The delete action was
      not run on a device.

## Submit

Submit for review once the project's checks pass and the body describes the
commit you push. When a later commit changes what the body says, update the
departures and the account with it.
