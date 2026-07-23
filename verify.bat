@echo off
REM File Name: verify.bat
REM Purpose: Verify workshop environment is correctly configured (Windows)
REM Usage: Run from inside the cloned Unciv directory

setlocal EnableDelayedExpansion

set REQUIRED_JAVA_VERSION=21
set MAX_JAVA_VERSION=23
set JAVA_CMD=
set JAVA_HOME_USED=

echo ========================================
echo Workshop Environment Verification
echo ========================================
echo.

REM -----------------------------------------------------------------------------
REM Step 1: Find Java (prefer JAVA_HOME if set)
REM -----------------------------------------------------------------------------
echo Step 1: Locating Java...

if defined JAVA_HOME (
    if exist "%JAVA_HOME%\bin\java.exe" (
        set "JAVA_CMD=%JAVA_HOME%\bin\java.exe"
        set "JAVA_HOME_USED=%JAVA_HOME%"
        echo   Using JAVA_HOME: %JAVA_HOME%
        echo   Java command: %JAVA_HOME%\bin\java.exe
        goto :check_version
    )
)

where java >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ERROR: Java is not installed or not in PATH.
    echo.
    echo To fix this:
    echo   1. Download JDK 21 from https://adoptium.net/
    echo   2. Run the installer
    echo   3. IMPORTANT: Check "Set JAVA_HOME variable" during installation
    echo   4. Open a NEW Command Prompt and run this script again
    echo.
    exit /b 1
)

for /f "tokens=*" %%i in ('where java') do (
    set "JAVA_CMD=%%i"
    echo   JAVA_HOME not set, using PATH java: %%i
    echo.
    echo   Note: Consider setting JAVA_HOME for reliability.
    goto :check_version
)

:check_version
REM -----------------------------------------------------------------------------
REM Step 2: Check Java version
REM -----------------------------------------------------------------------------
echo.
echo Step 2: Checking Java version...

REM Get java version output using the selected java command
for /f "usebackq tokens=3" %%i in (`"%JAVA_CMD%" -version 2^>^&1 ^| findstr /i "version"`) do (
    set JAVA_VERSION_STRING=%%i
    goto :got_version
)
:got_version

REM Remove quotes
set JAVA_VERSION_STRING=%JAVA_VERSION_STRING:"=%

REM Extract major version (handles both "21.0.2" and "1.8.0" formats)
for /f "tokens=1 delims=." %%i in ("%JAVA_VERSION_STRING%") do set JAVA_MAJOR=%%i

REM Handle old 1.x format
if "%JAVA_MAJOR%"=="1" (
    for /f "tokens=2 delims=." %%i in ("%JAVA_VERSION_STRING%") do set JAVA_MAJOR=%%i
)

echo   Java version: %JAVA_VERSION_STRING% (major: %JAVA_MAJOR%)

if %JAVA_MAJOR% LSS %REQUIRED_JAVA_VERSION% goto :java_too_old
if %JAVA_MAJOR% GTR %MAX_JAVA_VERSION% goto :java_too_new
echo   OK: Java %JAVA_MAJOR% is within the supported range %REQUIRED_JAVA_VERSION%-%MAX_JAVA_VERSION%
goto :check_jdk

:java_too_new
echo.
echo ERROR: Java version %JAVA_MAJOR% is too new. This workshop's Gradle 8.11.1 supports Java up to %MAX_JAVA_VERSION%.
echo Install JDK %REQUIRED_JAVA_VERSION% and point JAVA_HOME at it.
echo.
exit /b 1

:java_too_old
echo.
echo ERROR: Java version %JAVA_MAJOR% is too old. Version %REQUIRED_JAVA_VERSION% is required.
echo.

REM Try to detect JDK 21 installations
set DETECTED_JDK=
for %%p in (
    "C:\Program Files\Eclipse Adoptium\jdk-21*"
    "C:\Program Files\Java\jdk-21*"
    "C:\Program Files\Microsoft\jdk-21*"
    "C:\Program Files\Amazon Corretto\jdk21*"
) do (
    for /d %%d in (%%p) do (
        if exist "%%d\bin\java.exe" (
            set "DETECTED_JDK=%%d"
            goto :found_jdk
        )
    )
)
goto :no_jdk_found

:found_jdk
echo Found JDK 21 at: %DETECTED_JDK%
echo.
echo Run these commands and try again:
echo   set JAVA_HOME=%DETECTED_JDK%
echo   set PATH=%%JAVA_HOME%%\bin;%%PATH%%
echo.
exit /b 1

:no_jdk_found
echo To fix: Download JDK 21 from https://adoptium.net/
echo After installing, run:
echo   set JAVA_HOME=C:\path\to\your\jdk-21
echo   set PATH=%%JAVA_HOME%%\bin;%%PATH%%
echo.
exit /b 1

:check_jdk
REM -----------------------------------------------------------------------------
REM Step 3: Verify JDK (not just JRE)
REM -----------------------------------------------------------------------------
echo.
echo Step 3: Checking for JDK ^(compiler^)...

if defined JAVA_HOME_USED (
    set "JAVAC_PATH=%JAVA_HOME_USED%\bin\javac.exe"
) else (
    for /f "tokens=*" %%i in ('where javac 2^>nul') do (
        set "JAVAC_PATH=%%i"
        goto :check_javac
    )
    set JAVAC_PATH=
)

:check_javac
if exist "%JAVAC_PATH%" (
    echo   OK: javac found at %JAVAC_PATH%
    goto :check_gradle
)

echo.
echo ERROR: javac not found. You have a JRE, but need a JDK.
echo.
echo The JDK includes the compiler ^(javac^). A JRE does not.
echo Download JDK 21 from https://adoptium.net/
echo.
exit /b 1

:check_gradle
REM -----------------------------------------------------------------------------
REM Step 4: Check Gradle wrapper
REM -----------------------------------------------------------------------------
echo.
echo Step 4: Checking Gradle wrapper...

if not exist "gradlew.bat" (
    echo.
    echo ERROR: gradlew.bat not found in current directory.
    echo.
    echo This script must be run from inside the Unciv repository.
    echo Current directory: %CD%
    echo.
    echo Run:
    echo   cd C:\path\to\Unciv
    echo   verify.bat
    echo.
    exit /b 1
)

echo   Running: gradlew.bat --version
echo.

call gradlew.bat --version
if %ERRORLEVEL% neq 0 (
    echo.
    echo ERROR: Gradle wrapper failed to run.
    echo.
    if defined JAVA_HOME_USED (
        echo JAVA_HOME is set to: %JAVA_HOME_USED%
        echo Verify this path contains a valid JDK 21 installation.
    ) else (
        echo Try setting JAVA_HOME explicitly:
        echo   set JAVA_HOME=C:\path\to\jdk-21
    )
    echo.
    exit /b 1
)

echo.
echo   OK: Gradle wrapper works

REM -----------------------------------------------------------------------------
REM Step 5: Run upstream tests (verifies build works)
REM -----------------------------------------------------------------------------
echo.
echo Step 5: Running upstream tests ^(this may take a minute on first run^)...
echo.

call gradlew.bat :tests:test --tests "*.HolidayDatesTest" --quiet
if %ERRORLEVEL% neq 0 (
    echo.
    echo ERROR: Upstream tests failed.
    echo.
    echo Check the error messages above. Common issues:
    echo   - Network issues downloading dependencies
    echo   - Disk space issues
    echo.
    exit /b 1
)

echo   OK: Upstream tests pass

REM -----------------------------------------------------------------------------
REM Step 6: Run workshop tests (verifies scaffolding)
REM -----------------------------------------------------------------------------
echo.
echo Step 6: Running workshop tests...
echo.

call gradlew.bat :tests:test --tests "*.AlienSightingTrackerTest" --quiet
if %ERRORLEVEL% neq 0 (
    echo.
    echo ERROR: Workshop tests failed.
    echo.
    echo This may mean scaffolding is not installed correctly.
    echo Make sure you cloned: https://github.com/vempio/unciv-workshop.git
    echo And checked out the tdd-ai-workshop branch.
    echo.
    exit /b 1
)

echo   OK: Workshop tests pass

REM -----------------------------------------------------------------------------
REM Success
REM -----------------------------------------------------------------------------
echo.
echo ========================================
echo SUCCESS! Your environment is ready for the workshop.
echo ========================================
echo.
echo Optional: Run the full test suite to be extra sure:
echo.

if defined JAVA_HOME_USED (
    echo   set JAVA_HOME=%JAVA_HOME_USED%
    echo   gradlew.bat :tests:test
) else (
    echo   gradlew.bat :tests:test
)

echo.
echo Optional: Run the game to confirm everything works:
echo.

if defined JAVA_HOME_USED (
    echo   set JAVA_HOME=%JAVA_HOME_USED%
    echo   gradlew.bat :desktop:run
) else (
    echo   gradlew.bat :desktop:run
)

echo.
echo ^(Play a turn or two, then close the game.
echo  Or give in to the temptation and keep going. You know you want to ;-^) ^)
echo.
