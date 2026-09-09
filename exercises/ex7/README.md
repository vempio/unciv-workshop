# Exercise: Requirements Decomposition (Alien Invasion Response)

**Time**: 20 minutes (15 specification + 5 discussion — no coding)

## The Challenge

You've been handed a feature request for Unciv:

**"Add an alien invasion threat response to the game."**

That's it. That's the whole specification.

Sound familiar? This is how requirements arrive in the real world — one vague sentence,
wide open to interpretation. With AI you *can* generate code from that sentence. But the
AI will fill every gap with an invention and flag none of it — so what you get back is
plausible, detailed, and quite possibly not the feature anyone wanted.

Today you decompose the vague request into clear specifications **before** any code exists.

## The Domain (invented — so no one can lean on "how Civ works")

The Alien Invasion is a fictional expansion. Everything the player experiences is invented
for this workshop, which means you — not the game's existing rules — decide how it behaves.
The rough shape:

- Civilizations **detect** aliens through *sightings* (some number per turn).
- The more sightings, the higher the **threat** (you unit-built that calculator in §6).
- A higher threat calls for a stronger **defense response** (monitor → fortify → mobilize →
  evacuate).
- The player learns about all of this through **notifications**.

Your job is not to invent every number. It's to turn that loose narrative into a spec crisp
enough that another developer — or an AI — could build the right thing.

## Your Task

Working with the agent, produce three documents:

### 1. requirements.md — *what* and *why*
- What does "alien invasion threat response" actually include? (Detection? Assessment?
  Defensive action? Player feedback? All of it?)
- Who experiences it, and when?
- Concrete **acceptance criteria** — how would you know it works?
- **Edge cases**: no sightings at all; a sudden spike; a threat that persists for many
  turns; the very first turn.
- **Out of scope**: what this feature deliberately does *not* do.

### 2. plan.md — *how*
- What components are needed? (You already have an `InvasionThreatCalculator` from §6 — how
  does it fit? What else: a sighting tracker, a defense-readiness advisor, an integration
  layer that fires notifications?)
- How does this hook into Unciv? (Something must run each turn; something must reach the
  notification system.)
- What's invented data (threat brackets, readiness levels) vs. game integration?

### 3. tasks.md — *verifiable actions*
- The specific, ordered steps to build it.
- For each: how do you *know* it's done? (A passing test? A visible notification?)
- What sensible order builds this up — calculator, then response, then wiring?

## Success Looks Like

- Three markdown files that specify the feature clearly enough to hand off.
- Acceptance criteria specific enough that they'd catch the AI building the wrong thing.
- Edge cases surfaced that the one-sentence request never mentioned.
- The AI helped you *think*, not just generate.

## Getting Started

1. Run `./install-sdd-skills.sh` to install the three spec-driven skills, then start a
   fresh conversation with your harness. (The skills are optional scaffolding — see
   `sdd-skills/README.md`. Their worked example is a *different* feature on purpose.)
2. Ask it to help you enumerate what "alien invasion threat response" could mean — then
   *you* decide the scope. Don't accept its first list; interrogate it.
3. Build each document with the agent, one skill per layer: `/sdd.1-requirements` →
   `/sdd.2-plan` → `/sdd.3-tasks`. You steer, it drafts, you refine, you approve each gate.

## Important

**This is not a coding exercise.** You're deciding *what* to build before *how*. The next
two disciplines lean on this: §8 turns your acceptance criteria into Given/When/Then
scenarios; §6's unit tests already pin one of the components you're specifying here.

## Extensions (If You Finish Early)

- Ask the agent to critique your requirements.md: what's missing? Which acceptance
  criterion is untestable as written?
- Have it propose edge cases you didn't list — then decide which actually matter.
- Add a `user-stories.md`: "As a player under escalating threat, I want … so that …".
