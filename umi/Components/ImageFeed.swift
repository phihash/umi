import SwiftUI

struct ImageFeed: View {
    let imageURLs: [URL]
    @State private var selectedURL: URL?

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(imageURLs, id: \.self) { url in
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                        case .failure:
                            placeholder
                        default:
                            ProgressView()
                                .frame(maxWidth: .infinity, minHeight: 200)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .onTapGesture {
                        selectedURL = url
                    }
                }

                if imageURLs.isEmpty {
                    ForEach(0..<3, id: \.self) { _ in
                        placeholder
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 100)
        }
        .fullScreenCover(item: $selectedURL) { url in
            ZStack(alignment: .topTrailing) {
                Color.black.ignoresSafeArea()

                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }

                Button {
                    selectedURL = nil
                } label: {
                    Image(systemName: "xmark")
                        .font(.body.weight(.bold))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Circle().fill(.white.opacity(0.2)))
                }
                .padding(.top, 16)
                .padding(.trailing, 16)
            }
        }
    }

    private var placeholder: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                Image(systemName: "photo")
                    .foregroundColor(.gray.opacity(0.5))
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

extension URL: @retroactive Identifiable {
    public var id: String { absoluteString }
}
