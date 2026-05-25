# Exercise 1: The Productivity Trap

**Duration**: 15 minutes

---

## The Situation

You're working on Unciv, an open-source Civilization V clone. The game generates notifications for various events: wars declared, technologies researched, cities founded, diplomatic proposals, and more.

Players have requested **notification filtering** — they want to find specific notifications without scrolling through everything.

## Your Task

Implement a notification filter for Unciv.

**Requirements**:

1. **Filter by category**: War, Diplomacy, Production, Cities, etc.
2. **Filter by text**: Find notifications containing a search term
3. **Filter current turn**: Apply filters to `civilization.notifications`
4. **Filter history**: Apply filters to `civilization.notificationsLog` (past turns)
5. **Combine filters**: Category AND text should work together

## The Approach

Work quickly with your AI assistant. We have 15 minutes — focus on getting something working. Prompt, generate, iterate. Don't get bogged down in perfection.

## Starting Point

You have access to:

- `Notification.kt` — the notification data class
- `NotificationCategory` enum — War, Diplomacy, Production, Cities, etc.
- `Civilization.notifications` — current turn's notifications (simple list)
- `Civilization.notificationsLog` — historical notifications by turn (nested structure)

## Verifying Your Code

You can compile your code to check for syntax errors:

```bash
# From your unciv-workshop directory (whatever you cloned it to):
./gradlew :core:compileKotlin
```

This tells you if it compiles — not if it's correct.

## What "Done" Looks Like

You have code that compiles and appears to filter notifications. Whether it actually works correctly... that's what we'll discuss in the debrief.

## Time Check

- **0-3 min**: Understand the domain, read DOMAIN_REFERENCE.md
- **3-12 min**: Generate and iterate on implementation
- **12-15 min**: Compile, review what you have

---

*Remember: The goal is to move fast and ship something. Sound familiar?*
