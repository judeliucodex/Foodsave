// Feedback popups view

import SwiftUI

struct FeedbackView: View {
    let isCorrect: Bool
    let explanation: String
    let pointsEarned: Int
    let combo: Int
    let onNext: () -> Void

    private var accentColor: Color {
        isCorrect ? AppTheme.greenGlow : AppTheme.orangeAccent
    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.6).ignoresSafeArea()

            VStack(spacing: 24) {
                GlowingIcon(
                    systemName: isCorrect ? "checkmark.circle.fill" : "xmark.octagon.fill",
                    color: accentColor,
                    size: 70,
                    glowRadius: 20
                )

                VStack(spacing: 4) {
                    Text(isCorrect ? "+\(pointsEarned)" : "Not quite")
                        .font(.system(size: 48, weight: .black))
                        .foregroundStyle(accentColor)
                        .shadow(color: accentColor.opacity(0.4), radius: 10)

                    if isCorrect && combo > 1 {
                        Text("\u{1F525} \(min(combo, 5))x COMBO BONUS!")
                            .font(.title2.weight(.black))
                            .foregroundStyle(AppTheme.orangeAccent)
                            .shadow(color: .orange.opacity(0.5), radius: 6)
                    }
                }

                Text(explanation)
                    .font(.title3.weight(.medium))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.horizontal)
                    .padding(.top, 8)

                Button("Next") { onNext() }
                    .buttonStyle(VibrantButtonStyle(color: accentColor))
                    .padding(.horizontal, 40)
                    .padding(.top, 16)
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 24)
            .glassCard(cornerRadius: 32)
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(accentColor.opacity(0.6), lineWidth: 3)
            )
            .shadow(color: accentColor.opacity(0.3), radius: 30)
            .padding(.horizontal, 24)
        }
    }
}
