---
name: sdd.1-requirements
description: Capture WHAT a feature does and WHY, from the user's perspective, as testable acceptance criteria. Resist HOW.
---
# sdd.1-requirements

## Purpose

Turn a vague request into requirements someone could build *and test* from. You are
pinning down WHAT and WHY. Each time you catch yourself describing HOW (classes, files,
algorithms), stop -- that is the plan's job.

## Process

### 1. Find the job-to-be-done
Who is this for, and what are they actually trying to accomplish? "Add a tech tracker" is
a solution; "players lose track of how close their next technology is" is the job.

### 2. Ask before writing
Clarify the vague words. "Show progress" -- as a number, a bar, a turn estimate? Demand
concrete examples; surface the assumptions no one stated. Don't accept the AI's first list
of what the feature "should" include -- interrogate it.

### 3. Write testable acceptance criteria
Each criterion in Given / When / Then form, concrete enough to become a test. If you
cannot write the test, the requirement is not done.

### 4. Cut to an MVP
Sort into must-have (core goal impossible without it), should-have, nice-to-have, and
out-of-scope. The MVP is must-haves only -- and it must still deliver something a user
can observe.

## Output -> `requirements.md`
```markdown
# Feature: Technology Progress Tracker

## User story
As a player, I want to see how close my current research is to completing,
so that I can plan my next move without opening a menu.

## Acceptance criteria
- Given a technology is being researched, When I view the top bar,
  Then I see turns-remaining for it.
- Given no technology is selected, When I view the top bar,
  Then I see a "choose research" prompt, not a blank space.
- Given a technology just completed, When I view the top bar,
  Then it does NOT still show the finished tech.

## Scope
- Must: turns-remaining for the active technology.
- Nice: a progress bar; hovering shows beaker counts.
- Out:  changing *what* can be researched.

## Open questions
- [ASSUMPTION] "progress" means turns, not raw science points.
```

## Behaviors
- Challenge vague language: "fast" -> "under what?"; "users want" -> "which users?".
- Watch loaded words ("available", "current", "valid") -- pin down exactly what each
  means in code, or the implementation picks silently and it surfaces as a bug.
- Pair positive criteria with negative ones ("does NOT show already-completed techs").

## Gate
Stop. Show the draft. Get explicit agreement that it captures intent before `/sdd.2-plan`.
