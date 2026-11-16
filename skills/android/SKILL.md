---
name: android
description: Building an Android app in Kotlin and Compose, and, where it has native code, reusing the project's existing native build and tests and keeping JNI safe. Read it before designing or changing Android code
---

# Android

Where the product exists on another platform, `core.md`'s parity rule sets
the architecture and behaviour. This skill covers what Android adds.

## Kotlin and Compose

- **Kotlin and Jetpack Compose,** unless the repository has decided otherwise,
  built from the command line with the Gradle wrapper so CI and an agent build
  what Android Studio would.
- **Idiomatic, not ported.** Use the platform's lifecycle, coroutines, `Flow`
  and accessibility semantics. Matching another platform's behaviour is the
  goal; matching its type names or call shapes isn't.
- **Material is the default where the product's design doesn't decide,** not a
  reason to differ from it.

## Native code, when there is some

- **Reuse the existing native build.** When the project already builds its C++
  with CMake, Android's CMake consumes those targets, such as with
  `add_subdirectory`, rather than keeping a second source list or build
  definition of the same code.
- **Reuse the existing native tests.** Code that already has a unit test suite
  keeps it as the place its tests live; Android doesn't add a second test
  configuration for the same code without a reason it can name.
- **Pin the NDK and CMake versions** in Gradle, so every machine builds with
  the same compiler.

## JNI, where it is used

- **No C++ exception crosses JNI.** Every entry point catches and raises a
  Kotlin exception instead.
- **Native resources are released explicitly,** not by a finalizer or
  `Cleaner`, and never while a call may still be using them.
- **Don't hold a native lock across a call into Kotlin or Java code.** That
  code can call back into native code and wait on the same lock. JNI's own
  functions, such as building a string, are fine under one.
- **Attach a native thread before it uses a `JNIEnv`.** A thread the code
  attached is detached before it exits; one something else attached is left
  as it is.
- **References are freed deliberately.** A global reference lives only as long
  as the code that can still use it.
- **Blocking work stays off the main thread.**

## Tests

Each kind catches what the others can't; don't run the same thing twice.

- **JVM unit tests** for Kotlin logic, over fakes of anything native or
  device-bound.
- **Instrumented tests on a device or emulator** for what only runs there,
  such as the JNI boundary.
- **Compose UI tests** with the Compose test rule, for states, wording and
  navigation.
- **CI builds the app and its instrumented test APK and runs the JVM tests.**
  A test that needs hardware CI doesn't have is named in the change that relies
  on it, with who runs it.
