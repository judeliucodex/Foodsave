// Mistake review page

import SwiftUI

struct MistakeReviewView: View {
    let mistakes: [MistakeRecord]
    let onFinish: () -> Void
    @State private var currentIndex = 0

    var body: some View {
        ZStack {
            // Vibrant gradient background
            AppTheme.backgroundGradient.ignoresSafeArea()
            FloatingParticles(count: 12)

            VStack {
                Text("Let's Review")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .padding(.top, 20)

                Text("Mistake \(currentIndex + 1) of \(mistakes.count)")
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.6))

                TabView(selection: $currentIndex) {
                    ForEach(0..<mistakes.count, id: \.self) { index in
                        let mistake = mistakes[index]
                        mistakeCard(for: mistake)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))

                Button(currentIndex == mistakes.count - 1 ? "Finish Review" : "Next Mistake") {
                    if currentIndex < mistakes.count - 1 {
                        withAnimation { currentIndex += 1 }
                    } else {
                        onFinish()
                    }
                }
                .buttonStyle(VibrantButtonStyle(color: AppTheme.purpleAccent))
                .padding(.horizontal, 40)
                .padding(.bottom, 60)
            }
        }
    }

    private func mistakeCard(for mistake: MistakeRecord) -> some View {
        VStack(spacing: 20) {
            // Emoji with glow
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [AppTheme.purpleAccent.opacity(0.3), Color.clear],
                            center: .center,
                            startRadius: 0,
                            endRadius: 70
                        )
                    )
                    .frame(width: 120, height: 120)
                Text(mistake.item.emoji)
                    .font(.system(size: 70))
            }

            Text(mistake.item.name)
                .font(.title.bold())
                .foregroundStyle(.white)

            Text("Condition: \(mistake.item.details)")
                .font(.title3)
                .foregroundStyle(.white.opacity(0.6))

            // Guess vs Correct
            HStack(spacing: 20) {
                VStack {
                    Text("You Guessed")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.5))
                    Text(mistake.userChoseKeep ? "Keep" : "Dispose")
                        .font(.headline)
                        .foregroundStyle(mistake.userChoseKeep ? AppTheme.greenGlow : AppTheme.orangeAccent)
                }

                Rectangle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 1, height: 40)

                VStack {
                    Text("Correct Answer")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.5))
                    Text(mistake.item.isKeep ? "Keep" : "Dispose")
                        .font(.headline)
                        .foregroundStyle(mistake.item.isKeep ? AppTheme.greenGlow : AppTheme.orangeAccent)
                }
            }
            .padding()
            .glassCard(cornerRadius: 16)

            // Explanation
            Text(mistake.item.explanation)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.7))
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.cyan.opacity(0.2), lineWidth: 1)
                )

            Spacer()
        }
        .padding(30)
    }
}
