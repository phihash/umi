import SwiftUI

struct TitleBar: View {
    var body: some View {
        HStack {
            Text("流れてきた")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Capsule().fill(.orange))

            Spacer()

            Text("あなたが流したもの")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Capsule().fill(.orange))
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 12)
    }
}
