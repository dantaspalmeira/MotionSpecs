# Security Hardening

## Threat Model

MotionSpecs is an offline iOS design-engineering tool. The main risks are supply-chain drift, accidental secret commits, future privacy-sensitive API additions, and unsafe expansion of generated-code templates.

## Assets

- Source code and project configuration.
- Generated SwiftUI code displayed in the sheet.
- User clipboard after an explicit Copy action.
- GitHub repository integrity.

## Trust Boundaries

- iOS app sandbox.
- Xcode build system.
- GitHub repository and CI.
- User clipboard.

## Findings From Current Review

No high-risk runtime sinks were found in the current app:

- no `URLSession` or network APIs
- no credential handling
- no Keychain use
- no persistent storage
- no file read/write APIs
- no dynamic code execution
- no third-party dependencies

The only sensitive API surface is `UIPasteboard.general.string`, used only in `ClipboardManager.copy(_:)` after the user taps Copy.

## Applied Controls

- Added Apple privacy manifest declaring no tracking and no collected data.
- Added repository security policy.
- Added build workflow template for GitHub Actions.
- Kept build outputs ignored by Git.
- Kept app architecture local-only and dependency-free.

## Required Review For Future Changes

Run this checklist before adding features:

- If network is added, document endpoint trust, TLS assumptions, request contents, retry behavior, and logging policy.
- If storage is added, document retention, encryption, deletion, and whether Keychain is required.
- If user input starts influencing generated code templates, validate the exact interpolation boundaries and escape strategy.
- If third-party packages are added, check maintenance, license, transitive dependencies, and known advisories.
- If privacy-sensitive APIs are added, update `PrivacyInfo.xcprivacy` and Info.plist purpose strings.
- If GitHub Actions are enabled, require branch protection and reviews for workflow changes.
