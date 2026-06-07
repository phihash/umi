import SwiftUI

struct FABButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 56, height: 56)
                .background(Circle().fill(.orange))
        }
        .padding(.trailing, 20)
        .padding(.bottom, 40)
    }
}
