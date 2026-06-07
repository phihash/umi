import SwiftUI

struct NavBar: View {
    var body: some View {
        HStack {
            Spacer()
            NavigationLink(destination: MyPage()) {
                Circle()
                    .fill(Color.teal.opacity(0.7))
                    .frame(width: 36, height: 36)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .padding(.bottom, 16)
    }
}
