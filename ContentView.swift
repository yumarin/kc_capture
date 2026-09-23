import SwiftUI

struct ContentView: View {
    @StateObject private var store = KCDataStore.shared

    var body: some View {
        TabView {
            Text("WKWebViewゲーム画面\nここにKCWebViewを接続")
                .tabItem {
                    Label("ゲーム", systemImage: "gamecontroller")
                }

            List(store.ships) { ship in
                Text("艦娘ID \(ship.api_ship_id) Lv\(ship.api_lv)")
            }
            .tabItem {
                Label("艦隊", systemImage: "list.bullet")
            }

            List(store.slotItems) { item in
                Text("装備ID \(item.api_slotitem_id) ★\(item.api_level)")
            }
            .tabItem {
                Label("装備", systemImage: "shield")
            }
        }
    }
}