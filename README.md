# MotionSpecs

Native SwiftUI motion specs tool for previewing motion presets and generating SwiftUI code.

## Run Locally

Open `MotionSpecs/MotionSpecs.xcodeproj` in Xcode, select an iPhone simulator, then press `Cmd + R`.

## GitHub Actions

The iOS build workflow is prepared at `.github/workflows/ios-build.yml` in the local project.

GitHub requires a token with `workflow` scope to add or update files under `.github/workflows`. Once that permission is available, add the workflow file and it will build the app for iOS Simulator on every push to `main`/`master`, on pull requests, and manually through `workflow_dispatch`.

After a successful run, download the `MotionSpecs-iphonesimulator` artifact from the Actions run page.
