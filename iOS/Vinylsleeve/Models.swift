import Foundation

struct Tape: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var label: String
    var condition: String
    var notes: String
}
