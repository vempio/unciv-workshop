# Exercise 3: Practicing the Collaboration

**Duration**: 20 minutes + 10 minutes share-back

---

## The Discipline

In Exercise 2, you experienced the happy path of TDD with AI. Now we practice **the collaboration discipline**: you're the navigator (specifying), AI is the driver (implementing).

Both you and AI want to leap ahead — you toward "the interesting parts," AI toward assumptions and flashy features. The discipline of small steps constrains both of you.

## The Domain

Your Alien Sighting Tracker from Exercise 2 records incoming data. Now intelligence needs to **calculate threat levels** based on sighting frequency.

You'll design a threat assessment formula — then make AI discover it through triangulation.

## Your Task

Design and implement an `InvasionThreatCalculator` that converts sightings-per-turn into a threat score.

## Design Your Formula

Your formula must be **piecewise** — different rules for different ranges:

- **Low sightings** (e.g., 1-3): Background noise, threat = 0
- **Medium sightings** (e.g., 4-8): Some linear scaling
- **High sightings** (e.g., 9-15): Steeper scaling
- **Extreme sightings** (16+): Panic-level scaling

**Example formula** (yours will differ):

| Range | Rule |
|-------|------|
| 1-3 | 0 |
| 4-8 | (sightings - 3) × 10 |
| 9-15 | 50 + (sightings - 8) × 20 |
| 16+ | 190 + (sightings - 15) × 50 |

**Your job:**
1. Design your own brackets and multipliers
2. Calculate 4 concrete test values from YOUR formula
3. Write those as tests — AI must discover YOUR formula

## The Constraint

**Don't tell AI the formula. Only prompt: "Make this test pass."**

- Write tests with **concrete values** you calculated
- Each test constrains AI further until YOUR logic emerges
- Watch for AI weakening your assertions to make tests pass
- If AI proposes changing your expected value, push back — you designed the formula

## Triangulation in Action

Each test you add constrains AI's solution space:

1. **First test** — AI can return a constant
2. **Second test** — AI must generalize, but has many options
3. **Third test** — AI's first guess likely fails; it must revise
4. **Fourth test** — Your algorithm is pinned down

Watch AI evolve: constant → linear → piecewise. This is triangulation working.

## Running Tests

```bash
# From your unciv-workshop directory (whatever you cloned it to):
./gradlew :tests:test --tests "*.InvasionThreatCalculatorTest"
```

## What "Done" Looks Like

- A formula YOU designed (written on paper or in your head)
- 4 passing tests with concrete values from YOUR formula
- You never told AI the formula — only "make this test pass"
- You watched AI's implementation evolve through triangulation

## Time Check

- **0-3 min**: Design your formula, calculate 4 test values
- **3-8 min**: First two tests, watch AI generalize
- **8-15 min**: Third and fourth tests, see AI discover your pattern
- **15-20 min**: Review — does AI's formula match yours?

## Hints

- Start with a value from your "zero threat" range
- Pick test values from DIFFERENT brackets to force bracket discovery
- After each test passes, look at AI's implementation — what formula did it guess?
- When AI guesses wrong, the next test will fail — that's the point

## See It In-Game

The integration is already wired up. Once your calculator works:

1. Run Unciv and start a game
2. Every 3 turns, sightings trigger with varying intensity
3. When threat > 0, you'll see: *"Invasion threat: LOW/ELEVATED/HIGH/CRITICAL (value)"*

The notification values depend on YOUR formula — every participant's game will behave slightly differently.

---

*You're the navigator. You designed the formula. AI must discover it. Stay at the specification level and watch YOUR pattern emerge.*
