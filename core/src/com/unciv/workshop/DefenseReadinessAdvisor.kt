// DefenseReadinessAdvisor.kt
// Part of the "Alien Invasion" workshop expansion for Unciv
// Students build this class through TDD in Exercise 4

package com.unciv.workshop

/**
 * Defense actions in response to alien threat levels.
 */
enum class DefenseAction {
    IGNORE,     // Threat too low to warrant action
    MONITOR,    // Keep watching, no action needed yet
    FORTIFY,    // Strengthen defenses
    MOBILIZE,   // Active response, deploy military
    EVACUATE    // Critical threat, emergency measures
}

/**
 * Overall readiness assessment levels.
 */
enum class ReadinessLevel {
    CRITICAL,   // Severely unprepared
    LOW,        // Underprepared
    MODERATE,   // Adequate preparation
    HIGH,       // Well prepared
    OPTIMAL     // Fully prepared
}

/**
 * Advises on defense actions and resource needs based on threat level.
 *
 * EXERCISE: Design the rules collaboratively with your AI, then encode them as tests.
 * The stub implementations return wrong values — your tests will drive the real logic.
 */
class DefenseReadinessAdvisor {

    /**
     * Recommends a defense action based on threat level.
     * Design thresholds that make sense for gameplay.
     */
    fun recommendedAction(threatLevel: Int): DefenseAction {
        // Stub: always returns IGNORE
        return DefenseAction.IGNORE
    }

    /**
     * Calculates resources required to respond to threat level.
     * Design a cost curve — low responses should be cheap or free.
     */
    fun resourcesRequired(threatLevel: Int): Int {
        // Stub: always returns 0
        return 0
    }

    /**
     * Checks if the recommended action can be executed with available resources.
     */
    fun canExecuteAction(threatLevel: Int, availableResources: Int): Boolean {
        // Stub: always returns true
        return true
    }

    /**
     * Returns the best affordable action given resource constraints.
     * Falls back to cheaper actions if the recommended one isn't affordable.
     */
    fun fallbackAction(threatLevel: Int, availableResources: Int): DefenseAction {
        // Stub: always returns MONITOR
        return DefenseAction.MONITOR
    }

    /**
     * Calculates morale penalty from prolonged threat exposure.
     * Design brackets that escalate with duration but have a cap.
     */
    fun moralePenalty(turnsUnderThreat: Int): Int {
        // Stub: always returns 0
        return 0
    }

    /**
     * Assesses overall readiness based on threat, resources, and morale.
     * Design a composite score and thresholds for each readiness level.
     */
    fun overallReadiness(threatLevel: Int, availableResources: Int, morale: Int): ReadinessLevel {
        // Stub: always returns CRITICAL
        return ReadinessLevel.CRITICAL
    }
}
