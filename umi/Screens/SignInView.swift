import AuthenticationServices
import SwiftUI

struct SignInView: View {
    private var auth = AuthManager.shared

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 12) {
                Text("🌊")
                    .font(.system(size: 60))
                Text("あなたが流したものを\n見るにはサインインが必要です")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }

            Spacer()

            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.email]
            } onCompletion: { result in
                Task { await auth.handleAppleSignIn(result) }
            }
            .frame(height: 50)
            .padding(.horizontal, 40)
            .padding(.bottom, 48)
        }
    }
}
