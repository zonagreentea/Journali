import Foundation
import AuthenticationServices
import SwiftUI

/// LoT OIDC + PKCE client (lightweight placeholder)
final class LoTAuth: NSObject, ObservableObject {
    static let shared = LoTAuth()

    // Placeholder: read these from a secure config in real app
    private let clientID = "JOHN_APPLESEED_LOT_CLIENT_ID"
    private let baseURL = URL(string: "https://api.languageofthings.local")!

    @Published var isSignedIn = false
    @Published var accessToken: String? = nil

    private var currentSession: ASWebAuthenticationSession?

    func signIn(presentingWindow: UIWindow? = nil) {
        // Build OIDC authorize URL with PKCE (placeholder)
        let authURL = baseURL.appendingPathComponent("/authorize?client_id=\(clientID)&response_type=code&scope=openid%20profile%20offline_access&redirect_uri=liquidglass://callback&code_challenge=PLACEHOLDER&code_challenge_method=S256")

        currentSession = ASWebAuthenticationSession(url: authURL, callbackURLScheme: "liquidglass") { callbackURL, error in
            guard error == nil, let callbackURL = callbackURL else { return }
            // Exchange code for tokens — placeholder
            // In production, exchange code securely with token endpoint
            self.isSignedIn = true
            self.accessToken = "PLACEHOLDER_ACCESS_TOKEN"
        }

        currentSession?.presentationContextProvider = self
        currentSession?.start()
    }
}

extension LoTAuth: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first ?? ASPresentationAnchor()
    }
}
