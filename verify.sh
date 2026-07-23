#!/bin/bash
# File Name: verify.sh
# Purpose: Verify workshop environment is correctly configured (Mac/Linux)
# Usage: Run from inside the cloned Unciv directory

set -e

REQUIRED_JAVA_VERSION=21
JAVA_CMD=""
JAVA_HOME_USED=""

echo "========================================"
echo "Workshop Environment Verification"
echo "========================================"
echo ""

# -----------------------------------------------------------------------------
# Step 1: Find Java (prefer JAVA_HOME if set)
# -----------------------------------------------------------------------------
echo "Step 1: Locating Java..."

if [ -n "$JAVA_HOME" ] && [ -x "$JAVA_HOME/bin/java" ]; then
    JAVA_CMD="$JAVA_HOME/bin/java"
    JAVA_HOME_USED="$JAVA_HOME"
    echo "  Using JAVA_HOME: $JAVA_HOME"
    echo "  Java command: $JAVA_CMD"
elif command -v java &> /dev/null; then
    JAVA_CMD=$(command -v java)
    echo "  JAVA_HOME not set, using PATH java: $JAVA_CMD"
    echo ""
    echo "  Note: Consider setting JAVA_HOME for reliability."
else
    echo ""
    echo "ERROR: Java is not installed or not in PATH."
    echo ""
    echo "To fix this:"
    echo "  1. Download JDK 21 from https://adoptium.net/"
    echo "  2. Install it"
    echo "  3. Run:"
    echo "     export JAVA_HOME=/path/to/jdk-21"
    echo "     export PATH=\"\$JAVA_HOME/bin:\$PATH\""
    echo ""
    exit 1
fi

# -----------------------------------------------------------------------------
# Step 2: Check Java version
# -----------------------------------------------------------------------------
echo ""
echo "Step 2: Checking Java version..."

JAVA_VERSION_OUTPUT=$("$JAVA_CMD" -version 2>&1 | head -1)
echo "  $JAVA_VERSION_OUTPUT"

# Extract major version number (handles both "21.0.2" and "1.8.0" formats)
JAVA_VERSION=$("$JAVA_CMD" -version 2>&1 | head -1 | sed -E 's/.*version "([0-9]+).*/\1/')

if [ "$JAVA_VERSION" -ge "$REQUIRED_JAVA_VERSION" ] 2>/dev/null; then
    echo "  OK: Java $JAVA_VERSION meets requirement (>= $REQUIRED_JAVA_VERSION)"
else
    echo ""
    echo "ERROR: Java version $JAVA_VERSION is too old. Version $REQUIRED_JAVA_VERSION or later is required."
    echo ""

    # Try to find a suitable JDK and give concrete advice
    DETECTED_JDK=""

    if [ "$(uname)" == "Darwin" ]; then
        DETECTED_JDK=$(/usr/libexec/java_home -v $REQUIRED_JAVA_VERSION 2>/dev/null || true)
    else
        for path in /usr/lib/jvm/java-21-openjdk* /usr/lib/jvm/temurin-21* /usr/lib/jvm/java-21*; do
            if [ -d "$path" ] && [ -x "$path/bin/java" ]; then
                DETECTED_JDK="$path"
                break
            fi
        done
    fi

    if [ -n "$DETECTED_JDK" ]; then
        echo "Found JDK 21 at: $DETECTED_JDK"
        echo ""
        echo "Run these commands and try again:"
        echo "  export JAVA_HOME=\"$DETECTED_JDK\""
        echo "  export PATH=\"\$JAVA_HOME/bin:\$PATH\""
    else
        echo "To fix: Download JDK 21 from https://adoptium.net/"
        echo "After installing, run:"
        echo "  export JAVA_HOME=/path/to/your/jdk-21"
        echo "  export PATH=\"\$JAVA_HOME/bin:\$PATH\""
    fi
    echo ""
    exit 1
fi

# -----------------------------------------------------------------------------
# Step 3: Verify JDK (not just JRE)
# -----------------------------------------------------------------------------
echo ""
echo "Step 3: Checking for JDK (compiler)..."

if [ -n "$JAVA_HOME_USED" ]; then
    JAVAC_PATH="$JAVA_HOME_USED/bin/javac"
else
    JAVAC_PATH=$(command -v javac 2>/dev/null || true)
fi

if [ -x "$JAVAC_PATH" ]; then
    echo "  OK: javac found at $JAVAC_PATH"
else
    echo ""
    echo "ERROR: javac not found. You have a JRE, but need a JDK."
    echo ""
    echo "The JDK includes the compiler (javac). A JRE does not."
    echo "Download JDK 21 from https://adoptium.net/"
    echo ""
    exit 1
fi

# -----------------------------------------------------------------------------
# Step 4: Check Gradle wrapper
# -----------------------------------------------------------------------------
echo ""
echo "Step 4: Checking Gradle wrapper..."

if [ ! -f "./gradlew" ]; then
    echo ""
    echo "ERROR: gradlew not found in current directory."
    echo ""
    echo "This script must be run from inside the Unciv repository."
    echo "Current directory: $(pwd)"
    echo ""
    echo "Run:"
    echo "  cd /path/to/Unciv"
    echo "  /path/to/verify.sh"
    echo ""
    exit 1
fi

if [ ! -x "./gradlew" ]; then
    echo "  Making gradlew executable..."
    chmod +x ./gradlew
fi

echo "  Running: ./gradlew --version"
echo ""

if ! ./gradlew --version; then
    echo ""
    echo "ERROR: Gradle wrapper failed to run."
    echo ""
    if [ -n "$JAVA_HOME_USED" ]; then
        echo "JAVA_HOME is set to: $JAVA_HOME_USED"
        echo "Verify this path contains a valid JDK 21 installation."
    else
        echo "Try setting JAVA_HOME explicitly:"
        echo "  export JAVA_HOME=/path/to/jdk-21"
    fi
    echo ""
    exit 1
fi

echo ""
echo "  OK: Gradle wrapper works"

# -----------------------------------------------------------------------------
# Step 5: Run upstream tests (verifies build works)
# -----------------------------------------------------------------------------
echo ""
echo "Step 5: Running upstream tests (this may take a minute on first run)..."
echo ""

if ! ./gradlew :tests:test --tests "*.HolidayDatesTest" --quiet 2>&1; then
    echo ""
    echo "ERROR: Upstream tests failed."
    echo ""
    echo "Check the error messages above. Common issues:"
    echo "  - Network issues downloading dependencies"
    echo "  - Disk space issues"
    echo ""
    exit 1
fi

echo "  OK: Upstream tests pass"

# -----------------------------------------------------------------------------
# Step 6: Run workshop tests (verifies scaffolding)
# -----------------------------------------------------------------------------
echo ""
echo "Step 6: Running workshop tests..."
echo ""

if ! ./gradlew :tests:test --tests "*.AlienSightingTrackerTest" --quiet 2>&1; then
    echo ""
    echo "ERROR: Workshop tests failed."
    echo ""
    echo "This may mean scaffolding is not installed correctly."
    echo "Make sure you cloned: https://github.com/vempio/unciv-workshop.git"
    echo "And checked out the tdd-ai-workshop branch."
    echo ""
    exit 1
fi

echo "  OK: Workshop tests pass"

# -----------------------------------------------------------------------------
# Success
# -----------------------------------------------------------------------------
echo ""
echo "========================================"
echo "SUCCESS! Your environment is ready for the workshop."
echo "========================================"
echo ""
echo "Optional: Run the full test suite to be extra sure:"
echo ""

if [ -n "$JAVA_HOME_USED" ]; then
    echo "  JAVA_HOME=\"$JAVA_HOME_USED\" ./gradlew :tests:test"
else
    echo "  ./gradlew :tests:test"
fi

echo ""
echo "Optional: Run the game to confirm everything works:"
echo ""

if [ -n "$JAVA_HOME_USED" ]; then
    echo "  JAVA_HOME=\"$JAVA_HOME_USED\" ./gradlew :desktop:run"
else
    echo "  ./gradlew :desktop:run"
fi

echo ""
echo "Play a turn or two, then close the game."
echo " (Or give in to the temptation and keep going. You know you want to ;-) )"
echo ""
