// AlienSightingTrackerTest.kt
// Workshop exercise test file

package com.unciv.workshop

import org.junit.Assert.*
import org.junit.Test

/**
 * Exercise 2: Alien Sighting Tracker
 *
 * Build the AlienSightingTracker through TDD.
 *
 * The class exists in core/src/com/unciv/workshop/ with stubs.
 * Write tests here, then ask AI to make them pass.
 *
 * Once complete, run Unciv to see notifications every 3 turns!
 */
class AlienSightingTrackerTest {

    // EXAMPLE: This test passes with the stub (returns 0)
    @Test
    fun `new tracker has zero sightings`() {
        val tracker = AlienSightingTracker()
        assertEquals(0, tracker.totalSightings())
    }

    // TODO: Write more tests!
    // Next test idea: "recording a sighting increases total count"
    // This will FAIL with the stub - then ask AI to fix it.

}
