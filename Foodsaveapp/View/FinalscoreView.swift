// Final score page view

import SwiftUI

struct FinalScoreView: View {
    let finalScore: Int
    let playAgainAction: () -> Void
    let homeAction: () -> Void

    // Read high score directly so it's always current, even after multiple "Play Again" rounds
    @AppStorage("highScore") private var highScore: Int = 0

    private let fdaURL = URL(string: "https://www.fda.gov/food/buy-store-serve-safe-food/safe-food-handling")

    var body: some View {
        ZStack {
            // Vibrant gradient background
            AppTheme.backgroundGradient.ignoresSafeArea()
            FloatingParticles(count: 25)

            VStack(spacing: 30) {
                Spacer()

                GlowingIcon(
                    systemName: "trophy.circle.fill",
                    color: AppTheme.yellowAccent,
                    size: 100,
                    glowRadius: 30
                )

                Text("Time's Up!")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                VStack(spacing: 10) {
                    Text("Final Score")
                        .font(.title2)
                        .foregroundStyle(.white.opacity(0.6))
                    Text("\(finalScore)")
                        .font(.system(size: 70, weight: .black))
                        .foregroundStyle(.white)
                        .shadow(color: AppTheme.yellowAccent.opacity(0.4), radius: 15)
                }

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(AppTheme.yellowAccent)
                    Text("High Score: \(max(finalScore, highScore))")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .glassCard(cornerRadius: 20)

                if let url = fdaURL {
                    Link("Read FDA Food Safety Guidelines", destination: url)
                        .font(.footnote.bold())
                        .foregroundStyle(.cyan)
                        .padding(.top, 10)
                }

                Spacer()

                VStack(spacing: 14) {
                    Button("Play Again") { playAgainAction() }
                        .buttonStyle(VibrantButtonStyle(color: AppTheme.greenGlow))

                    Button("Back to Home") { homeAction() }
                        .buttonStyle(GlassButtonStyle())
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 60)
            }
        }
    }
}
