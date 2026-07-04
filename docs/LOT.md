# Language-of-Things (LoT) integration notes

This repository integrates with the Language-of-Things project as an authentication and optional sync gateway. Refer to https://github.com/zonagreentea/Language-of-Things for server-side examples.

Default strategy:
- Native Apple devices: sync using iCloud (NSPersistentCloudKitContainer).
- Web & fallback: sync using LoT REST endpoints.

LoT expectations (client):
- OIDC authorize endpoint (authorize)
- Token endpoint (token) supporting authorization_code + refresh_token
- userinfo endpoint
- entries CRUD endpoints (POST /entries, GET /entries, PUT /entries/:id, DELETE /entries/:id)

Scopes suggested: openid profile offline_access journals.read journals.write

Security notes:
- Tokens are stored in Keychain (native) or secure storage for web (service worker-safe storage).
- Device signing (if required by LoT) should be performed via a secure server-side key unless a secure Enclave-backed key is available on-device.

If you need a custom signing flow, provide the LoT signing documentation and we will extend LoT/Auth to support it.
