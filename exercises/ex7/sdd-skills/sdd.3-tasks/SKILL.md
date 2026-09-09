---
name: sdd.3-tasks
description: Break an approved plan into small, ordered, independently-verifiable tasks - walking skeleton first.
---
# sdd.3-tasks

## Purpose

Turn the plan into a checklist you could hand to someone (including an agent) and trust.
Each task is small, has a visible done-condition, and leaves the project working.
**Prerequisite:** an approved `plan.md`.

## Process

### 1. Break into atomic units
Each task ~30 min to 2 h, one clear outcome. Touching more than ~3 files usually means it
should split.

### 2. Sequence for early integration
Walking skeleton first (the end-to-end path working), then the integration points, then
polish. The point is to surface surprises early, while they are cheap.

### 3. Keep every task whole
Each task leaves the build green and the feature testable -- not "wire it up later". A
change that breaks callers includes fixing those callers in the *same* task. No orphaned
"write the tests" or "write the docs" tasks -- those ride with the behaviour.

## Output -> `tasks.md`
```markdown
# Tasks: Technology Progress Tracker

- [ ] 1. Render a hard-coded "5 turns" label in the top bar (walking skeleton).
        Done: label visible on a running game.
- [ ] 2. Replace the constant with real turns-remaining from TechManager.
        Done: label tracks the actual research and updates each turn.
- [ ] 3. Handle "no research selected" -> show the prompt.
        Done: starting with no tech selected shows the prompt, not a blank.
- [ ] 4. (nice-to-have) Add the progress bar behind the label.
        Done: bar fills as research advances.
```

## Behaviors
- Each task names its own done-condition; "looks right" is not one.
- Mark which tasks are safe to run autonomously vs which want a review checkpoint
  (irreversible, correctness-critical, or novel work wants eyes on it).

## Gate
Show the task list. Confirm the sequence -- skeleton first -- before implementing.
