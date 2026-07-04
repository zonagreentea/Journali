# TestFlight & upload checklist for the System Analyst

This document lists the exact steps to prepare the repository for automated TestFlight upload using the provided Fastlane configuration.

1. Create an App record in App Store Connect and note the Bundle ID(s).
2. Create an App Store Connect API key (Issuer ID, Key ID) and download the .p8 file.
3. In the repository Settings → Secrets → Actions, add the following secrets:
   - APP_STORE_CONNECT_ISSUER_ID
   - APP_STORE_CONNECT_KEY_ID
   - APP_STORE_CONNECT_PRIVATE_KEY (paste the contents of the .p8)
   - APPLE_TEAM_ID
4. In the Apple Developer portal, create App IDs and enable capabilities:
   - iCloud (CloudKit)
   - Push Notifications (if desired)
   - Sign in with Apple (optional)
5. Update the Xcode project settings with the real bundle IDs and team, then archive and upload once the secrets are present.

If you prefer manual upload, open the workspace in Xcode, set signing to your team, archive, then upload to App Store Connect.
