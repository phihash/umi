import SwiftUI

struct MyPage: View {
    private var auth = AuthManager.shared
    @State private var showSignOutAlert = false

    var body: some View {
        VStack {
            Spacer()

            Text("マイページ")

            Spacer()

            if auth.isSignedIn {
                Button(role: .destructive) {
                    showSignOutAlert = true
                } label: {
                    Text("サインアウト")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .padding(.horizontal, 40)
                .padding(.bottom, 32)
            }
        }
        .alert("サインアウトしますか？", isPresented: $showSignOutAlert) {
            Button("キャンセル", role: .cancel) {}
            Button("サインアウト", role: .destructive) {
                Task { await auth.signOut() }
            }
        }
    }
}
