import SwiftUI
import Combine // Required for ObservableObject

final class AppSettings: ObservableObject {
    @Published var isHapticsEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isHapticsEnabled, forKey: "isHapticsEnabled")
        }
    }

    @Published var isDeveloperMode: Bool {
        didSet {
            UserDefaults.standard.set(isDeveloperMode, forKey: "isDeveloperMode")
        }
    }

    init() {
        // Haptics: default true on first launch
        if UserDefaults.standard.object(forKey: "isHapticsEnabled") == nil {
            self.isHapticsEnabled = true
        } else {
            self.isHapticsEnabled = UserDefaults.standard.bool(forKey: "isHapticsEnabled")
        }

        // Developer mode: default false
        self.isDeveloperMode = UserDefaults.standard.bool(forKey: "isDeveloperMode")
    }
}
