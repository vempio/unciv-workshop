# Pre-Workshop Environment Setup

Complete these steps **before the workshop**. If you encounter issues, contact the trainer with the error output.

## What You Need

1. **Java Development Kit (JDK) 21 or later** — not just Java Runtime (JRE)
2. **Git** — to clone the exercise repository
3. **Your AI coding assistant** — configured and working in your IDE

## Step 1: Install JDK 21

You need a JDK (Java Development Kit), not just a JRE (Java Runtime Environment). The JDK includes the compiler.

### Download Options

| Provider | URL | Notes |
|----------|-----|-------|
| Eclipse Temurin (recommended) | https://adoptium.net/ | Free, well-maintained, all platforms |
| Oracle JDK | https://www.oracle.com/java/technologies/downloads/ | Official Oracle release |
| Amazon Corretto | https://aws.amazon.com/corretto/ | AWS-maintained, good for corporate environments |

**Choose JDK 21 or later.** Any of the above will work.

### Platform-Specific Installation

**Windows:**
1. Download the `.msi` installer from Adoptium
2. Run the installer
3. **Important:** Check the box "Set JAVA_HOME variable" during installation

**macOS:**
1. Download the `.pkg` installer from Adoptium, OR
2. Use Homebrew: `brew install --cask temurin@21`

**Linux:**
```bash
# Debian/Ubuntu
sudo apt install openjdk-21-jdk

# Fedora
sudo dnf install java-21-openjdk-devel

# Arch
sudo pacman -S jdk21-openjdk
```

## Step 2: Verify Your Installation

Open a **new** terminal (to pick up environment changes) and run:

```bash
java -version
```

You should see output mentioning version 21 (or higher):
```
openjdk version "21.0.2" 2024-01-16
...
```

Also verify the compiler is available:
```bash
javac -version
```

Should output: `javac 21.0.2` (or similar)

## Step 3: Clone the Workshop Repository

```bash
git clone https://github.com/vempio/unciv-workshop.git
cd unciv-workshop
git checkout tdd-workshop
```

## Step 4: Run the Verification Script

Download the verification script for your platform from the workshop materials, place it in the unciv-workshop directory, and run it.

**Mac/Linux:**
```bash
cd unciv-workshop
chmod +x verify.sh
./verify.sh
```

**Windows (Command Prompt or PowerShell):**
```cmd
cd unciv-workshop
verify.bat
```

### What the Script Checks

1. Java version is 21 or later
2. JAVA_HOME is set correctly (or suggests how to set it)
3. Gradle wrapper can start
4. Upstream Unciv tests pass
5. Workshop scaffolding tests pass

### Successful Output

If everything works, you'll see:
```
SUCCESS! Your environment is ready for the workshop.

Optional: Run the full test suite to be extra sure:

  JAVA_HOME="/path/to/jdk" ./gradlew :tests:test

Optional: Run the game to confirm everything works:

  JAVA_HOME="/path/to/jdk" ./gradlew :desktop:run
```

## Troubleshooting

### "java: command not found"

Java is not installed or not in your PATH.

**Windows:** Re-run the installer and ensure "Add to PATH" is checked.

**Mac/Linux:** Add to your shell profile (`~/.bashrc`, `~/.zshrc`):
```bash
export PATH="/path/to/jdk/bin:$PATH"
```

### "JAVA_HOME is not set"

The JAVA_HOME environment variable tells tools where to find Java. Set it in your current terminal session:

**Windows (Command Prompt):**
```cmd
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-21.0.2.13-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%
```

**Mac/Linux:**
```bash
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH="$JAVA_HOME/bin:$PATH"
# on Mac with Homebrew:
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH="$JAVA_HOME/bin:$PATH"
```

Run the verification script again after setting these.

### "Java version is X, but 21+ is required"

You have an older Java version. Install JDK 21, then set JAVA_HOME and PATH to point to it (see above).

### "gradlew: Permission denied" (Mac/Linux)

```bash
chmod +x gradlew
./gradlew --version
```

### "Could not determine java version" or Gradle errors

Usually means JAVA_HOME points to a JRE, not a JDK. Verify:
```bash
ls $JAVA_HOME/bin/javac    # Should exist
```

If `javac` is missing, JAVA_HOME points to a JRE. Update it to point to a JDK.

### IntelliJ IDEA Issues

If IntelliJ builds fail but command-line Gradle works:

1. Open IntelliJ Settings → Build, Execution, Deployment → Build Tools → Gradle
2. Set "Gradle JVM" to your JDK 21 installation
3. File → Invalidate Caches and Restart

**Workaround:** Use the terminal for running tests during the workshop:
```bash
./gradlew :tests:test --tests "*.YourTestName"
```

## Still Having Issues?

Contact the trainer with:
1. Your operating system and version
2. Output of `java -version`
3. Output of `echo $JAVA_HOME` (Mac/Linux) or `echo %JAVA_HOME%` (Windows)
4. The full error message from the verification script
