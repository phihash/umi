import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
        ZStack(alignment: .bottomTrailing) {
            Color(red: 0.92, green: 0.92, blue: 0.91)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                NavBar()
                TitleBar()
                ImageFeed()
            }

            FABButton {}
        }
        }
    }
}
