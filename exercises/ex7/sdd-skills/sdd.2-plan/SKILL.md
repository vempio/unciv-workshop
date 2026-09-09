---
name: sdd.2-plan
description: Translate approved requirements into a technical approach - components, integration points, risks - without dropping to line-level implementation.
---
# sdd.2-plan

## Purpose

Decide HOW, at the structural level. Enough that someone could start building and hit no
nasty surprises -- not so much that you have written the code in prose.
**Prerequisite:** an approved `requirements.md`.

## Process

### 1. Restate the target
One line: the feature and its must-haves, so the plan stays anchored to them.

### 2. Choose an approach
If there are real alternatives, give 2-3 with trade-offs and a recommendation. If one
sensible path exists, state it with the reasoning.

### 3. Ground it in the existing code
Where does this hook into what already exists? Which patterns should it follow? What is
already there to reuse rather than rebuild? (Re-inventing existing helpers is a classic AI
failure.) The code is the ground truth, not stale docs.

### 4. Name the walking skeleton
The thinnest end-to-end path you could build first and *watch work* -- stated in user
terms, no technical nouns. It crosses every layer thinly, so integration surprises show up
on day one, not at the end.

### 5. Try to break it
What single assumption, if wrong, sinks this? What is cheaper and almost as good? What
will differ in the real game vs your mental model? Revise, or record why it holds.

## Output -> `plan.md`
```markdown
# Plan: Technology Progress Tracker

## Approach
Read the active research from the existing TechManager and render turns-remaining in the
existing top-bar UI. No new game state; pure read-and-display.

## Walking skeleton
Start a game, research a tech, and see a turns number appear in the top bar.

## Components
| Component     | Purpose              | Integrates with                          |
|---------------|----------------------|------------------------------------------|
| TopBar widget | show turns-remaining | TechManager (read), WorldScreen (render) |

## Risks
| Risk                                  | Mitigation                                    |
|---------------------------------------|-----------------------------------------------|
| turns-remaining recalculated mid-turn | read the same source the research screen uses |
```

## Behaviors
- Reference integration points by name ("reads TechManager.researchOfTech()").
- Mark assumptions you can only confirm by running it: `[VERIFY IN WALKING SKELETON]`.

## Gate
Stop. Show the plan. Get agreement before `/sdd.3-tasks`.
