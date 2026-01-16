// AlienSightingTracker.kt
// Part of the "Alien Invasion" workshop expansion for Unciv
// Students build this class through TDD in Exercise 2

package com.unciv.workshop

/**
 * Tracks alien sightings across turns for a civilization.
 *
 * EXERCISE: This class has stub implementations. Students write tests,
 * then ask AI to make them pass, evolving these stubs into working code.
 *
 * The game runs with stubs (showing "0 sightings" in notifications).
 * Once students implement properly, notifications show accurate counts.
 */
class AlienSightingTracker {

    // TODO: Students will add storage here through TDD

    fun recordSighting(turn: Int, location: String) {
        // Stub: does nothing - students will implement via TDD
    }

    fun totalSightings(): Int {
        // Stub: returns 0 - will fail test "recording increases count"
        return 0
    }

    fun sightingsOnTurn(turn: Int): Int {
        // Stub: returns 0
        return 0
    }
}
