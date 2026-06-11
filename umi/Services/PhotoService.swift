import Foundation
import Supabase
import UIKit

struct Photo: Codable {
    let id: UUID
    let createdAt: Date
    let userId: UUID
    let imagePath: String

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case userId = "user_id"
        case imagePath = "image_path"
    }
}

private struct PhotoInsert: Encodable {
    let userId: UUID
    let imagePath: String

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case imagePath = "image_path"
    }
}

enum PhotoService {
    static func upload(_ image: UIImage) async throws {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        let userId = try await supabase.auth.session.user.id
        let fileName = "\(userId.uuidString)/\(UUID().uuidString).jpg"

        try await supabase.storage.from("photos").upload(
            path: fileName,
            file: data,
            options: .init(contentType: "image/jpeg")
        )

        try await supabase.from("photos")
            .insert(PhotoInsert(userId: userId, imagePath: fileName))
            .execute()
    }

    static func fetchAll() async throws -> [URL] {
        let photos: [Photo] = try await supabase.from("photos")
            .select()
            .order("created_at", ascending: false)
            .execute()
            .value

        return try photos.map { photo in
            try supabase.storage.from("photos").getPublicURL(path: photo.imagePath)
        }
    }
}
