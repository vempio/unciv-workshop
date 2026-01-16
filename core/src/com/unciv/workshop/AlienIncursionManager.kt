// AlienIncursionManager.kt
// Integration layer for the Alien Invasion workshop expansion
// Connects AlienSightingTracker (Ex2) and InvasionThreatCalculator (Ex3) to the game

package com.unciv.workshop

import com.unciv.logic.civilization.Civilization
import com.unciv.logic.civilization.NotificationCategory

/**
 * Manages alien incursion events for a civilization.
 *
 * Integration flow:
 * 1. Every 3 turns, generate a deterministic number of sightings
 * 2. Record them in the tracker (Ex2)
 * 3. Query the tracker for this turn's count
 * 4. Pass that count to the threat calculator (Ex3)
 * 5. Show notifications
 *
 * The tracker and calculator logic are tested in isolation; this manager handles game integration.
 */
class AlienIncursionManager(private val civInfo: Civilization) {

    // The tracker that students build through TDD in Exercise 2
    private val tracker = AlienSightingTracker()

    // The threat calculator that students build through TDD in Exercise 3
    private val threatCalculator = InvasionThreatCalculator()

    // How often incursion events occur (every N turns)
    private val incursionFrequency = 3

    /**
     * Called at start of turn to check if an incursion event should occur.
     */
    fun checkForSighting(currentTurn: Int) {
        if (currentTurn > 0 && currentTurn % incursionFrequency == 0) {
            triggerIncursionEvent(currentTurn)
        }
    }

    /**
     * Triggers an alien incursion event.
     */
    private fun triggerIncursionEvent(turn: Int) {
        // Deterministic sighting count - cycles through threat brackets
        val sightingCount = getSightingCount(turn)

        // Pick location
        val location = civInfo.cities.randomOrNull()?.name
            ?: civInfo.getCapital()?.name
            ?: "the frontier"

        // Record sightings in tracker (Ex2 - stub does nothing)
        repeat(sightingCount) {
            tracker.recordSighting(turn, location)
        }

        // Calculate threat from sighting count (Ex3 - stub returns 0)
        val threatLevel = threatCalculator.calculateThreat(sightingCount)

        // Show notifications using sightingCount (works even with stubs)
        showSightingNotification(sightingCount, location)

        if (threatLevel > 0) {
            showThreatNotification(threatLevel)
        }
    }

    /**
     * Deterministic sighting count based on turn number.
     * Cycles through different values to exercise all threat brackets.
     */
    private fun getSightingCount(turn: Int): Int {
        val eventNumber = turn / incursionFrequency
        return when (eventNumber % 5) {
            0 -> 2   // noise bracket (threat = 0)
            1 -> 6   // low threat (30)
            2 -> 9   // medium threat (70)
            3 -> 12  // high threat (130)
            else -> 4 // low threat (10)
        }
    }

    private fun showSightingNotification(count: Int, location: String) {
        val total = tracker.totalSightings()
        val message = if (total == count) {
            "First contact! $count alien sightings near [$location]!"
        } else {
            "$count alien sightings near [$location]! ($total total)"
        }
        civInfo.addNotification(
            message,
            NotificationCategory.War,
            "OtherIcons/Pillage"
        )
    }

    private fun showThreatNotification(threatLevel: Int) {
        val severity = when {
            threatLevel >= 200 -> "CRITICAL"
            threatLevel >= 100 -> "HIGH"
            threatLevel >= 50 -> "ELEVATED"
            else -> "LOW"
        }
        civInfo.addNotification(
            "Invasion threat: $severity ($threatLevel)",
            NotificationCategory.War,
            "OtherIcons/Exclamation"
        )
    }

    /** Returns the tracker for querying sighting data. */
    fun getTracker(): AlienSightingTracker = tracker

    /** Returns the threat calculator for external use. */
    fun getThreatCalculator(): InvasionThreatCalculator = threatCalculator
}
