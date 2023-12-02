import Foundation
import SwiftUI
struct Todo: Identifiable, Codable{
    let id: UUID
    var title: String
    var isCompleted: Bool
    var rowColorRed: Double
    var rowColorBlue: Double
    var rowColorGreen: Double
    var date: Date
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, rowColorRed: Double = 0, rowColorBlue: Double = 0, rowColorGreen: Double = 0, date: Date = Date()) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.rowColorRed = rowColorRed
        self.rowColorBlue = rowColorBlue
        self.rowColorGreen = rowColorGreen
        self.date = date
    }
}
