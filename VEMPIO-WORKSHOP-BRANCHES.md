# vempio Workshop Branches

This is a vempio fork of Unciv used as the exercise codebase for AI/coding
workshops. Branch layout:

| Branch | Purpose |
|--------|---------|
| `master` | Upstream Unciv mirror. Do not put course content here. |
| `agentic-ai-workshop` | Base codebase for the Agentic AI Workshop (lighter exercises). |
| `tdd-ai-workshop` | Base codebase for the TDD with AI Workshop (elaborate exercises: Alien Invasion scaffolding). |
| `debug-water-spawn` | Agentic debug exercise: base plus a planted "units spawn on water" bug. Cloned separately for that one exercise. |

## Delivery model

- One branch per course. Participants clone their course branch once at setup;
  it carries the game source and the up-to-date install instructions
  (PRE-WORKSHOP-SETUP.md, verify scripts).
- Progressive in-session exercise reveals (scaffolding, staged prompts) are
  delivered as password-protected zips, not branches. Unzipping is additive and
  never clobbers a participant's uncommitted work.
- Rule of thumb: after setup, participants only unzip; they never switch
  branches in place. Whole-codebase variants (e.g. debug-water-spawn) are used
  via a separate clone, not an in-place checkout.

Consuming repos (vempio/agentic-ai-workshop, vempio/tdd-ai-workshop) pin this
fork as a submodule at context/Unciv and track their matching branch.
