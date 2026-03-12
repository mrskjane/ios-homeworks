import Foundation

struct Post {
    let author: String
    let description: String
    let detailedText: String
    let image: String
    var likes: Int
    var views: Int
    
    static func makeMockPosts() -> [Post] {
        return [
            Post(author: "Mrs_Jane",
                 description: "Незабываемый вид на горы...",
                 detailedText: "Незабываемый вид на горы. Мы поднимались туда около 4 часов, было тяжело, но оно того стоило. Воздух кристально чистый, а тишина просто оглушает. Рекомендую всем посетить это место хотя бы раз в жизни!",
                 image: "post_image_1", likes: 52, views: 125),
            
            Post(author: "Foddie_Jane",
                 description: "Сегодня приготовила хлеб на закваске...",
                 detailedText: "Сегодня приготовила хлеб на закваске... Впервые. Получилось невероятно вкусно! Рецепт простой: 100г закваски, 350мл воды, 500г муки и соль. Главный секрет — долгое брожение в холодильнике.",
                 image: "post_image_2", likes: 34, views: 120),
            
            Post(author: "Mrs_Jane",
                 description: "Новый год всей семьей.",
                 detailedText: "Новый год всей семьей. Что может быть лучше?! В этом году мы решили не ходить в рестораны, а устроить уютный вечер дома с настольными играми и домашним какао.",
                 image: "post_image_3", likes: 16, views: 76),
            
            Post(author: "Mom_Jane",
                 description: "Раньше этому празднику не придавали значения.",
                 detailedText: "Раньше этому празднику не придавали значения. Не помню, чтобы в школе мы готовили поздравления для мамы. Хорошо, что времена изменились, и теперь мы можем открыто благодарить своих близких за их любовь.",
                 image: "post_image_4", likes: 13, views: 83)
        ]
    }
}
