import Foundation

enum StringConstant {
    static let destination = "📍место"
    static let date = "🗓 дата поездки"
    
    enum TabBarTitle {
        static let main = "Лента путешествий"
        static let profile = "Моя страница"
        static let favorites = "Избранное"
    }
}

extension String {
    enum LabelType: String {
        case trips = "поездки"
        case subscriptions = "подписок"
        case followers = "подписчиков"
    }
    
    static func createLabel(type: LabelType, with number: Int) -> String {
        "\(number)\n\(type.rawValue)"
    }
}
