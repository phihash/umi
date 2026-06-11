import SwiftUI

struct ConfirmPostView: View {
    let image: UIImage
    let onPost: () -> Void
    let onChangePhoto: () -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var isUploading = false

    var body: some View {
        VStack(spacing: 24) {
            Text("この写真を海に流しますか？")
                .font(.headline)
                .padding(.top, 32)

            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 24)

            Spacer()

            VStack(spacing: 12) {
                Button {
                    isUploading = true
                    Task {
                        do {
                            try await PhotoService.upload(image)
                            onPost()
                            dismiss()
                        } catch {
                            print("Upload error: \(error)")
                        }
                        isUploading = false
                    }
                } label: {
                    if isUploading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Capsule().fill(.orange.opacity(0.5)))
                    } else {
                        Text("流す")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Capsule().fill(.orange))
                    }
                }
                .disabled(isUploading)

                Button {
                    dismiss()
                    onChangePhoto()
                } label: {
                    Text("写真を変える")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .disabled(isUploading)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }
}
