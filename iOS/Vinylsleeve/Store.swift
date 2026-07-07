import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published private(set) var items: [Tape] = []
    @Published var isPro: Bool = false

    static let freeLimit = 25

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("vinylsleeve", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: Tape) {
        guard canAddMore else { return }
        items.append(item)
        save()
    }

    func update(_ item: Tape) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Tape) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([Tape].self, from: data) {
            items = decoded
        } else {
            items = Store.seedData
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }

    static var seedData: [Tape] {
        [
        Tape(id: UUID(), title: "Nevermind", label: "DGC Records", condition: "Good", notes: "Original press"),
        Tape(id: UUID(), title: "Rumours", label: "Warner Bros", condition: "Mint", notes: "Reissue"),
        Tape(id: UUID(), title: "Thriller", label: "Epic", condition: "Fair", notes: "Well loved")
        ]
    }
}
