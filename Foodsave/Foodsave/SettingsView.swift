import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Text("Settings")
                .foregroundColor(.white)
                .font(.title)
        }
    }
}
