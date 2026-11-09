---
name: design
description: Writing a design document, with a table beside its TLDR showing where the implementation effort is and a challenge to whatever makes it costly. Read it before drafting or revising any design
---

# Writing a design

## Where the work is

A significant design puts a table beside its TLDR, so the owner sees where the
effort goes before approving the direction. Each major area gets a share of the
implementation effort, and the shares sum to 100%. Every row gets a note on
what makes it cost more than its specification suggests.

The shares are rough and comparative, for discussion. They are not a schedule,
a commitment, or precise. Round them to fives and don't defend the digits.

| Area | Share | What makes it cost more than it looks |
|---|---|---|
| Sync between devices | 45% | Edits made offline on two devices to the same list need a merge rule, and the store keeps no edit history to merge from. |
| The list screen | 25% | Reordering by drag has to stay smooth with a thousand items, so rows can't be rebuilt on every change. |
| Import from the old format | 20% | The old files have no version field, so the reader has to tell three layouts apart by their shape. |
| Settings | 10% | Each setting has to reach every device, so it goes through sync rather than staying local. |

## Challenge what the table shows

The table is where the design's judgment starts, not where it ends. For each
row, the design:

- **names the concrete source:** the detail, not the category. "Rows can't be
  rebuilt on every change", not "performance".
- **proposes the simpler alternative,** if one exists, and says what it gives
  up: "last write wins per list removes the merge rule, and loses one device's
  edits when both change the same list offline."
- **challenges the requirement** when the requirement is the cost. That is a
  question to the owner among the design's decisions, with what it would save:
  "Is offline editing on two devices needed? Without it, sync drops from
  45% to about 10%." Never a quiet cut.
- **says why the complexity stays** when it does, once, where that decision is
  argued.

A row whose share is out of proportion to what it delivers is the first place
to look for one of these.

Ruled out: hours, days, story points, and a share without a reason. A row
reading "Tests: 10%" with no cost note is filler; fold it into the areas it
tests.

## Length is not thoroughness

A losing alternative needs the reason it lost, not a tour of it, and a decision
needs its argument once. The document is finished when everything left in it is
load-bearing.
