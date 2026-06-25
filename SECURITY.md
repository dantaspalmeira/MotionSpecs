# Security Policy

## Supported Scope

MotionSpecs is a native SwiftUI prototype with no backend, no network calls, no third-party dependencies, and no persistent user data storage.

The current security boundary is the iOS app sandbox. The app generates SwiftUI code locally and writes that generated text to the clipboard only when the user taps Copy.

## Reporting a Vulnerability

If you find a security issue, do not publish exploit details publicly until it is reviewed.

Report with:

- affected file and line
- reproduction steps
- expected impact
- whether user interaction is required

## Security Requirements For Changes

Before merging changes:

- Do not add secrets, API keys, tokens, certificates, or provisioning profiles to the repository.
- Do not add network access without an explicit threat model update.
- Do not add file system, pasteboard read, camera, microphone, location, contacts, photo library, or tracking APIs without a privacy manifest update.
- Do not add third-party packages without dependency review and license review.
- Keep generated code deterministic and free of user-controlled executable templates.
- Keep clipboard access write-only and user-initiated.
- Keep build artifacts, DerivedData, archives, and local cache files out of Git.

## Current Security Posture

- Data collection: none.
- Network access: none.
- Persistent storage: none.
- External dependencies: none.
- Clipboard: write-only, user-initiated copy action.
- Privacy manifest: included at `MotionSpecs/MotionSpecs/PrivacyInfo.xcprivacy`.
