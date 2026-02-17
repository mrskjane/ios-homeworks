
import Foundation

struct Photo {
    static func makeMockPhotos() -> [String] {
        let imageQuantity = 20
        var photos: [String] = []
        for i in 1...imageQuantity {
            photos.append("Image_\(i)")
        }
        return photos
    }
}
