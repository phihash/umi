import SwiftUI

struct NavBar: View {
    @State private var showMyPage = false

    var body: some View {
        HStack {
            Spacer()
            Button {
                showMyPage = true
            } label: {
                Circle()
                    .fill(Color.teal.opacity(0.7))
                    .frame(width: 36, height: 36)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .padding(.bottom, 16)
        .sheet(isPresented: $showMyPage) {
            MyPage()
        }
    }
}
