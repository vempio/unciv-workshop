# Exercise 5: Capstone — Complete the Advisor

**Duration**: 40 minutes + 15 minutes debrief

---

## The Challenge

In Exercise 4, you captured 20+ test ideas and implemented 5-6. You left with a backlog of empty test functions — documented intent, not failure.

Now finish the job.

## Your Task

1. Open your `DefenseReadinessAdvisorTest.kt` from Exercise 4
2. Pick up where you left off
3. Implement your remaining tests, one by one
4. Maintain the constraint: **you write specs, AI writes implementation**

No new domain to learn. No new patterns. Just more reps.

## The Constraint

**Specs and prompts only.**

- You write test code
- AI writes implementation code
- If AI's implementation is wrong, write a failing test that shows why

This is the discipline. Stick to it.

## Priority Guidance

If unsure which tests to tackle next:

**High value (do first):**
- `fallbackAction` — has real logic, not just thresholds
- `overallReadiness` — composite behavior, uses other methods
- Boundary cases you skipped

**Medium value:**
- Additional `recommendedAction` boundaries
- Additional `resourcesRequired` values
- `canExecuteAction` edge cases

**Lower priority (if time permits):**
- Negative input handling
- Extreme values
- Redundant boundary tests

## The Three Stages — Still Apply

Even for "just implementing more tests," staging helps:

**Stage 1:** Scan your empty functions. Which matter most?

**Stage 2:** Add AAA outlines to your next 3-4 priorities.

**Stage 3:** Implement one at a time. Red-green each before moving on.

Don't just plow through randomly. Be intentional.

## Running Tests

```bash
# From your unciv-workshop directory (whatever you cloned it to):
./gradlew :tests:test --tests "*.DefenseReadinessAdvisorTest"
```

## What "Done" Looks Like

There's no fixed finish line. Success is:

- More tests passing than when you started
- Maintained the spec-first constraint throughout
- Can articulate what behaviors are now covered vs. still pending
- Experienced the rhythm of sustained TDD

If you finish all your tests: congratulations! Help a neighbor, or add edge cases you hadn't considered.

## Time Check

- **0-5 min**: Review your backlog, pick priorities
- **5-35 min**: Implement tests, one at a time
- **35-40 min**: Note where you ended up for debrief

## Refine Your Process

This is 40 minutes of real work. Use it to improve how you collaborate with AI.

**Pay attention to your prompts:**
- What instructions work well? What falls flat?
- When does AI over-implement or under-implement?
- What phrasing gets the cleanest results?

**Iterate on your approach:**
- If something isn't working, change it
- Keep notes on what you adjust
- Your TDD prompt should be better at the end than the start

## Reflection Questions

As you work, notice:

- Where does the rhythm feel natural?
- Where do you want to grab the keyboard and "just fix it"?
- How does AI respond to well-specified vs. vague tests?
- What prompt adjustments made the biggest difference?

We'll discuss in the debrief.

---

*This isn't a new challenge. It's practice. TDD is a skill — you build it through repetition, not variety.*
