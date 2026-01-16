package com.unciv.workshop

import org.junit.Assert.*
import org.junit.Test

/**
 * Exercise 3: Invasion Threat Calculator
 *
 * Design YOUR OWN piecewise threat formula, then make AI discover it.
 *
 * Your formula must have 3-4 brackets. Example structure:
 *   - Low sightings (e.g., 1-3): threat = 0
 *   - Medium (e.g., 4-8): threat = (sightings - 3) × YOUR_MULTIPLIER
 *   - High (e.g., 9-15): threat = BASE + (sightings - 8) × STEEPER_MULTIPLIER
 *   - Extreme (16+): even steeper
 *
 * Steps:
 *   1. Design your formula (write it down!)
 *   2. Calculate 4 test values from DIFFERENT brackets
 *   3. Write tests with those values
 *   4. Only prompt: "make this test pass" — don't tell AI the formula
 *
 * Watch AI's implementation evolve as you add each test.
 */
class InvasionThreatCalculatorTest {

    // Design your formula FIRST, then write tests.
    //
    // Pick values from different brackets to force AI to discover
    // the piecewise structure through triangulation.
    //
    // Example (use your own values):
    //   @Test fun `threat is 0 when sightings are 2`()
    //   @Test fun `threat is 30 when sightings are 6`()
    //   etc.

}
