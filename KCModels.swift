import Foundation
import Combine

struct ShipExportInfo: Identifiable {
    var id: Int { api_ship_id }
    let api_ship_id: Int
    let api_lv: Int
}

struct SlotItemExportInfo: Identifiable {
    var id: Int { api_slotitem_id }
    let api_slotitem_id: Int
    let api_level: Int
}

final class KCDataStore: ObservableObject {
    static let shared = KCDataStore()

    @Published var ships:[ShipExportInfo] = []
    @Published var slotItems:[SlotItemExportInfo] = []

    private init(){}
}