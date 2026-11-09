---
name: issue-authoring
description: Writing or updating an issue, its sections and the decisions made while discussing it. Read it before filing, drafting or editing any issue
---

# Writing an issue

An issue is the control channel for one outcome. Write it so the next person to
pick it up can build from the body alone, without rereading the discussion.

## The shape

In this order. A repository's template may add sections, and its own wins where
they differ.

- **Context:** why this exists, linking the design or parent it comes from
  rather than restating it.
- **Outcome:** what is true when it's done, in one or two sentences.
- **Scope:** the changes expected, by file, layer or component where known.
- **Acceptance criteria:** a checklist of observable, testable facts. They are
  the definition of done.
- **Out of scope:** what someone might assume is included but isn't, and where
  it lives instead.
- **Dependencies:** issues this can't be built or verified without, by
  reference. Work it enables is not a dependency.

One outcome per issue, sized to one pull request. Larger work is a parent with
children.

## Decisions

Once an issue has been discussed, it gets a `## Decisions` section after
Acceptance criteria. Edit it in place as each decision is made, and change the
rest of the body to agree with it, so the body never contradicts the latest
decision. One line per decision, each one of:

- **Agreed:** what was decided, linked to the comment that agreed it.
- **Exploratory:** a suggestion nobody has accepted. An implementer may not
  treat it as a requirement.
- **Rejected:** what was turned down, and why.

For example:

    ## Decisions
    - **Agreed:** retries back off exponentially, capped at a minute ([comment](…)).
    - **Exploratory:** a per-host retry budget.
    - **Rejected:** retrying forever: a dead host would hold its worker.

Record only what the discussion settled or raised. A suggestion nobody agreed
to is Exploratory, however reasonable it sounds; don't promote it to Agreed or
write it into the criteria. Something agreed with no comment to link to was
agreed somewhere else: link that, or ask.

No transcript and no attribution of who said what. The section says what stands
now, not how the discussion got there.
