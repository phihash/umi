import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var selectedTab: FeedTab = .explore
    @State private var imageURLs: [URL] = []
    @State private var photoItem: PhotosPickerItem?
    @State private var showPicker = false
    @State private var pendingImage: UIImage?
    private var auth = AuthManager.shared

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Color(red: 0.92, green: 0.92, blue: 0.91)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    NavBar()
                    TitleBar(selectedTab: $selectedTab)

                    switch selectedTab {
                    case .explore:
                        ImageFeed(imageURLs: imageURLs)
                    case .mine:
                        if auth.isSignedIn {
                            ImageFeed(imageURLs: imageURLs)
                        } else {
                            SignInView()
                        }
                    }
                }

                if selectedTab == .explore {
                    FABButton {
                        showPicker = true
                    }
                }
            }
        }
        .task {
            await fetchPhotos()
        }
        .photosPicker(isPresented: $showPicker, selection: $photoItem)
        .onChange(of: photoItem) {
            guard let photoItem else { return }
            Task {
                if let data = try? await photoItem.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    pendingImage = image
                }
                self.photoItem = nil
            }
        }
        .sheet(item: $pendingImage) { image in
            ConfirmPostView(image: image) {
                pendingImage = nil
                Task { await fetchPhotos() }
            } onChangePhoto: {
                pendingImage = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showPicker = true
                }
            }
        }
    }

    private func fetchPhotos() async {
        do {
            imageURLs = try await PhotoService.fetchAll()
        } catch {
            print("Fetch error: \(error)")
        }
    }
}

extension UIImage: @retroactive Identifiable {
    public var id: ObjectIdentifier { ObjectIdentifier(self) }
}
