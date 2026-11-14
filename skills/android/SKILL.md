---
name: android
description: Building an Android app in Kotlin and Compose, over shared C++ where there is some: native builds with CMake that reuse the shared targets, the JNI boundary, its lifetime and threads, and which tests run where. Read it before designing or changing Android code
---

# Android

Android follows `core.md`'s parity rule: start from how the established platform
owns, threads and ends things, and say what differs and why. This skill covers
what Android adds.

## Kotlin and Compose

- **Kotlin and Jetpack Compose,** built from the command line with Gradle's
  wrapper, so CI and an agent build exactly what Android Studio would. Kotlin
  and native warnings are errors.
- **The established design is the baseline.** Material components are the
  default where it doesn't decide. They aren't a reason to differ from it.
- **The UI is a projection.** A `ViewModel` holds the screen's own presentation
  state, such as what is expanded. The model, its rules and anything outliving
  the screen belong to the shared code or to an application-owned object,
  never to a screen.
- **Idiomatic, not ported.** Use the platform's lifecycle, coroutines, `Flow`
  and accessibility semantics. Matching another platform's behaviour is the
  goal; matching its type names or call shapes isn't.

## Native code builds with CMake, from the shared targets

- **One build of the shared code.** Android's CMake, under the Gradle module,
  adds the shared library's own CMake directories with `add_subdirectory` and
  links its targets. It keeps no source list of its own, so a source added to
  the shared code reaches Android without an Android change.
- **Platform definitions live in a platform directory,** such as
  `src/android`, compiled under `if(ANDROID)`. Any other build system that takes
  every source under a path excludes it.
- **The same C++ standard as the shared code.** The JNI library declares the
  shared target's standard, rather than relying on it to propagate. A lower
  one needs a named toolchain constraint.
- **Our warnings stay errors.** A shared header that warns under the app's
  flags is fixed. Only third-party code is included as `SYSTEM`.
- **Pin the NDK and CMake versions** in Gradle, so CI and every machine build
  with the same compiler.

## The JNI boundary

The shared code never depends on JNI. The app owns its adapter.

- **Structured values cross,** built field by field into Kotlin objects, with
  class and method IDs cached once. Not JSON, not display strings, and enums
  mapped exhaustively with a test that covers every native value.
- **Every entry point translates exceptions.** A C++ exception never unwinds
  through JNI. It becomes one Kotlin exception type carrying the native
  message.
- **Lifetime is explicit.** A native object is held as a handle by one Kotlin
  object with a `close()`. Closing refuses new calls, waits for those in
  flight, then destroys. A finalizer or `Cleaner` is not how anything is
  released.
- **Callbacks from native threads** attach for the call and detach after it,
  hold no native lock while in the JVM, and only signal: they publish to a
  `Flow` and let the UI re-read. A global reference a callback uses is freed
  only after the threads that call it are joined.
- **Threading matches the established platform.** Short calls are synchronous
  where the other platform's are. Blocking work, such as construction, file
  loading and shutdown, stays off the main thread.

## Tests

Each kind catches what the others can't. Run each where it can run, and don't
run the same thing twice.

- **Native:** the shared code's existing CMake test suite, on the host where it
  already runs. Android's own native code, such as its platform definitions,
  gets tests in that same suite or through the JNI tests below. There's no
  second test configuration.
- **JVM unit tests** for Kotlin logic, such as lifecycle, gates and mappings,
  over fakes of the native layer. These run in CI.
- **Instrumented tests on a device** for the JNI boundary: linking, conversion,
  exception translation and callbacks across threads.
- **Compose UI tests** with the Compose test rule, over a fake model, for
  states, wording and navigation.
- **CI builds the app and its instrumented test APK** on every change that can
  break the Android build, including a change to the shared code, and runs the
  JVM tests. A test that needs hardware CI doesn't have is named in the change
  that relies on it, with who runs it.
