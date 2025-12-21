import Foundation

struct Post {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
    
    static func makeMockPosts() -> [Post] {
        return [
            Post(author: "Mrs_Jane", description: "Незабываемый вид на горы...Просто нет слов", image: "post_image_1", likes: 522, views: 1256),
            Post(author: "Foddie_Jane", description: "Сегодня приготовила хлеб на закваске...Впервые. Получилось невероятно вкусно!", image: "post_image_2", likes: 346, views: 1200),
            Post(author: "Mrs_Jane", description: "Новый год всей семьей. Что может быть лучше?!", image: "post_image_3", likes: 167, views: 768),
            Post(author: "Mom_Jane", description: "Раньше этому празднику не придавали значения. Не помню, чтобы в школе мы готовили поздравления для мамы. Хорошо, что времена изменились.", image: "post_image_4", likes: 135, views: 283)
        ]
    }
}
