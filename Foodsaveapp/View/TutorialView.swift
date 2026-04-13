// How to play page view

import SwiftUI

struct TutorialView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentPage = 0
    @State private var rightDragOffset: CGSize = .zero
    @State private var leftDragOffset: CGSize = .zero

    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.backgroundGradient.ignoresSafeArea()
                FloatingParticles(count: 12)

                TabView(selection: $currentPage) {
                    // Step 1: Keep
                    VStack(spacing: 24) {
                        Text("Step 1: Keep")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)

                        Text("If the food is safe to consume, you Keep it.\n**Swipe the card RIGHT.**")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white.opacity(0.7))

                        Spacer()

                        ZStack {
                            let overlayOpacity = rightDragOffset.width > 0
                                ? min(rightDragOffset.width / 120, 0.45)
                                : 0
                            dummyCard(emoji: "\u{1F34E}", title: "Perfect Apple")
                            RoundedRectangle(cornerRadius: 32)
                                .fill(AppTheme.greenGlow.opacity(overlayOpacity))
                                .frame(height: 380)
                                .padding(.horizontal, 30)
                        }
                        .offset(x: rightDragOffset.width, y: 0)
                        .rotationEffect(.degrees(Double(rightDragOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged { v in
                                    if v.translation.width > 0 { rightDragOffset = v.translation }
                                }
                                .onEnded { v in
                                    if v.translation.width > 120 {
                                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                        withAnimation { rightDragOffset = .zero; currentPage = 1 }
                                    } else {
                                        withAnimation(.spring()) { rightDragOffset = .zero }
                                    }
                                }
                        )

                        Spacer()
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 40)
                    .tag(0)

                    // Success: Keep
                    successPage(
                        icon: "checkmark.seal.fill",
                        color: AppTheme.greenGlow,
                        title: "Great Job!",
                        message: "You correctly kept the perfectly good food.",
                        buttonTitle: "Learn to Dispose",
                        action: { withAnimation { currentPage = 2 } }
                    )
                    .tag(1)

                    // Step 2: Dispose
                    VStack(spacing: 24) {
                        Text("Step 2: Dispose")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)

                        Text("If the food is dangerous or fully rotten, Dispose.\n**Swipe the card LEFT.**")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white.opacity(0.7))

                        Spacer()

                        ZStack {
                            let overlayOpacity = leftDragOffset.width < 0
                                ? min(abs(leftDragOffset.width) / 120, 0.45)
                                : 0
                            dummyCard(emoji: "\u{1F922}", title: "Moldy Meat")
                            RoundedRectangle(cornerRadius: 32)
                                .fill(AppTheme.orangeAccent.opacity(overlayOpacity))
                                .frame(height: 380)
                                .padding(.horizontal, 30)
                        }
                        .offset(x: leftDragOffset.width, y: 0)
                        .rotationEffect(.degrees(Double(leftDragOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged { v in
                                    if v.translation.width < 0 { leftDragOffset = v.translation }
                                }
                                .onEnded { v in
                                    if v.translation.width < -120 {
                                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                        withAnimation { leftDragOffset = .zero; currentPage = 3 }
                                    } else {
                                        withAnimation(.spring()) { leftDragOffset = .zero }
                                    }
                                }
                        )

                        Spacer()
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 40)
                    .tag(2)

                    // Success: Dispose
                    successPage(
                        icon: "trash.circle.fill",
                        color: AppTheme.orangeAccent,
                        title: "Perfect!",
                        message: "You safely disposed of the bad food.",
                        buttonTitle: "I'm Ready to Play",
                        action: { dismiss() }
                    )
                    .tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .navigationTitle("How to Play")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") { dismiss() }
                        .foregroundStyle(.white)
                }
            }
        }
    }

    private func successPage(icon: String, color: Color, title: String, message: String, buttonTitle: String, action: @escaping () -> Void) -> some View {
        VStack(spacing: 24) {
            Spacer()

            GlowingIcon(
                systemName: icon,
                color: color,
                size: 100,
                glowRadius: 25
            )

            Text(title)
                .font(.system(size: 40, weight: .bold))
                .foregroundStyle(.white)

            Text(message)
                .font(.title2)
                .foregroundStyle(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Spacer()

            Button(buttonTitle) { action() }
                .buttonStyle(VibrantButtonStyle(color: color))
                .padding(.horizontal, 40)
                .padding(.bottom, 80)
        }
    }

    @ViewBuilder
    private func dummyCard(emoji: String, title: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .fill(.ultraThinMaterial)
                .shadow(color: AppTheme.purpleAccent.opacity(0.3), radius: 25, x: 0, y: 15)
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                )

            VStack(spacing: 24) {
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [AppTheme.purpleAccent.opacity(0.3), Color.clear],
                                center: .center,
                                startRadius: 0,
                                endRadius: 80
                            )
                        )
                        .frame(width: 150, height: 150)
                    Text(emoji)
                        .font(.system(size: 90))
                }

                VStack(spacing: 8) {
                    Text(title)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.white)
                    Text("Swipe me!")
                        .font(.title3)
                        .foregroundStyle(.white.opacity(0.5))
                }
            }
        }
        .frame(height: 380)
        .padding(.horizontal, 30)
    }
}
