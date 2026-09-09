# Spec-driven skills: requirements -> plan -> tasks

Three small Agent Skills that walk a vague feature request through the spec-driven stack
*before* any code is written:

| Skill | Question it answers | Output |
|-------|---------------------|--------|
| `sdd.1-requirements` | WHAT and WHY (not how)        | `requirements.md` |
| `sdd.2-plan`         | HOW, at the structural level  | `plan.md` |
| `sdd.3-tasks`        | the concrete, ordered steps   | `tasks.md` |

They are a deliberately simplified distillation of a much larger production pipeline --
each is about a screenful, so you can read and adapt it in minutes. The real thing adds
adversarial passes, MVP-carving, reachability gates and more; these keep only the spine.

## The worked example is a *different* feature -- on purpose

Each skill shows its output on Unciv's "technology progress tracker", NOT the alien-invasion
threat response you are decomposing in this exercise. That is deliberate: you get to see the
*shape* of a good requirements.md / plan.md / tasks.md without being handed your own answer.
Map the method onto your feature; don't copy the content.

## Using them

1. Run `../install-sdd-skills.sh` to copy the three folders into this exercise's
   `.claude/skills/` directory.
2. Invoke them by name in order -- `/sdd.1-requirements`, then `/sdd.2-plan`, then
   `/sdd.3-tasks` -- stopping to review each artefact at its gate before the next.

They are not tied to one tool: `SKILL.md` is the shared Agent Skills standard, so the same
folder works in Claude Code (`.claude/skills/`), Codex (`.agents/skills/`), and Copilot
(`.github/skills/`). The installer targets `.claude/skills/`; for another harness, copy the
`sdd.*` folders into its skills directory instead.

## A skill is just a folder

    sdd.1-requirements/
      SKILL.md    # YAML frontmatter (name + description) + a prompt body

The frontmatter's `description` is what the harness matches against your task; the body is
the prompt. It packages an *action*, not durable coding rules -- those belong in your
always-on instructions file.
