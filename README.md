# MotionSpecs

Native SwiftUI motion specs tool for previewing motion presets and generating SwiftUI code.

## Run Locally

Open `MotionSpecs/MotionSpecs.xcodeproj` in Xcode, select an iPhone simulator, then press `Cmd + R`.

## GitHub Actions

This repo includes `.github/workflows/ios-build.yml`.

The workflow builds the app for iOS Simulator on every push to `main`/`master`, on pull requests, and manually through `workflow_dispatch`.

After a successful run, download the `MotionSpecs-iphonesimulator` artifact from the Actions run page.
