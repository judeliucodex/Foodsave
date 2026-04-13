//haptics



import UIKit

final class GameFeedbackManager {
    let settings: AppSettings
    
    init(settings: AppSettings) {
        self.settings = settings
    }
    
    func playSuccess() {
        if settings.isHapticsEnabled {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }
    
    func playFailure() {
        if settings.isHapticsEnabled {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
}
