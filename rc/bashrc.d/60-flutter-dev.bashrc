##  Flutter Development Environment Configuration
##

# Flutter SDK
export FLUTTER_ROOT="/home/egustafson/.development/flutter"
export PATH="$FLUTTER_ROOT/bin:$PATH"

# Dart SDK (included with Flutter)
export PATH="$FLUTTER_ROOT/bin/cache/dart-sdk/bin:$PATH"

# Android SDK
export ANDROID_HOME="/home/egustafson/.development/android-sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"

# Android SDK Tools
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$ANDROID_HOME/tools:$PATH"
export PATH="$ANDROID_HOME/tools/bin:$PATH"

# Java (for Android development)
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"

# Chrome for Flutter web development
export CHROME_EXECUTABLE="/usr/bin/chromium"

# Pub cache (Dart/Flutter packages)
export PATH="$HOME/.pub-cache/bin:$PATH"

# Flutter optimizations
export PUB_CACHE="$HOME/.pub-cache"

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
