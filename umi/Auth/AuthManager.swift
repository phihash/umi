import AuthenticationServices
import Foundation
import Observation
import Supabase

@Observable
@MainActor
class AuthManager {
    static let shared = AuthManager()

    var isSignedIn = false

    private init() {
        Task {
            isSignedIn = (try? await supabase.auth.session) != nil
        }
    }

    func handleAppleSignIn(_ result: Result<ASAuthorization, Error>) async {
        do {
            guard case .success(let auth) = result,
                  let credential = auth.credential as? ASAuthorizationAppleIDCredential,
                  let tokenData = credential.identityToken,
                  let idToken = String(data: tokenData, encoding: .utf8)
            else { return }

            try await supabase.auth.signInWithIdToken(
                credentials: .init(provider: .apple, idToken: idToken)
            )
            isSignedIn = true
        } catch {
            print("Apple sign in error: \(error)")
        }
    }

    func signOut() async {
        try? await supabase.auth.signOut()
        isSignedIn = false
    }
}
