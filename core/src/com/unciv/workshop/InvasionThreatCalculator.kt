// InvasionThreatCalculator.kt
// Part of the "Alien Invasion" workshop expansion for Unciv
// Students build this class through TDD in Exercise 3

package com.unciv.workshop

/**
 * Calculates invasion threat level based on sighting frequency.
 *
 * EXERCISE: This class has a stub implementation that compiles but returns wrong values.
 * Students write tests with specific expected values, then ask AI to make them pass,
 * which will evolve this stub into the correct piecewise algorithm.
 *
 * The game will run with this stub (showing "Threat: 0") but tests will fail
 * until properly implemented through triangulation.
 */
class InvasionThreatCalculator {

    /**
     * Calculates threat level from sightings per turn.
     *
     * Students have test data but not the formula:
     *   2 sightings → 0 threat
     *   6 sightings → 30 threat
     *   12 sightings → 130 threat
     *   20 sightings → 440 threat
     *
     * The formula must be discovered through triangulation.
     */
    fun calculateThreat(sightingsPerTurn: Int): Int {
        // Stub: always returns 0
        // Students will evolve this through TDD
        return 0
    }
}
