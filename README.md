# MotionSpecs

Native SwiftUI motion specs tool for previewing motion presets and generating SwiftUI code.

## Run Locally

Open `MotionSpecs/MotionSpecs.xcodeproj` in Xcode, select an iPhone simulator, then press `Cmd + R`.

## Web Demo

GitHub Pages serves a static browser demo at:

https://dantaspalmeira.github.io/MotionSpecs/

The web demo mirrors the motion controls and code-generation flow. The native SwiftUI app remains the source of truth for iOS.

## GitHub Actions

The iOS build workflow is prepared at `.github/workflows/ios-build.yml` in the local project.

GitHub requires a token with `workflow` scope to add or update files under `.github/workflows`. Once that permission is available, add the workflow file and it will build the app for iOS Simulator on every push to `main`/`master`, on pull requests, and manually through `workflow_dispatch`.

After a successful run, download the `MotionSpecs-iphonesimulator` artifact from the Actions run page.
