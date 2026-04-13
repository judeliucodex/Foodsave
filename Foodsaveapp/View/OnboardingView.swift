import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @AppStorage("userName") private var userName: String = ""

    @State private var currentPage = 0
    @State private var nameInput = ""

    var body: some View {
        ZStack {
            // Dark gradient background
            AppTheme.backgroundGradient.ignoresSafeArea()
            FloatingParticles(count: 18)

            VStack {
                Spacer()

                // PAGE CONTENT
                ZStack {
                    if currentPage == 0 {
                        pageZero
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    } else if currentPage == 1 {
                        missionPage(
                            icon: "trash.circle.fill",
                            color: .red,
                            title: "The Problem",
                            bodyText: "Millions of perfectly good meals are thrown away every single day. We are wasting food at a massive scale while grocery bills keep rising."
                        )
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    } else if currentPage == 2 {
                        missionPage(
                            icon: "questionmark.folder.fill",
                            color: AppTheme.orangeAccent,
                            title: "The Confusion",
                            bodyText: "Aesthetic bias and confusing labels are the main culprits. People throw away spotted bananas or misunderstand 'Best Before' dates."
                        )
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    } else if currentPage == 3 {
                        pageThree
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    }
                }
                .animation(.easeInOut(duration: 0.35), value: currentPage)

                Spacer()

                // CUSTOM PAGE DOTS
                HStack(spacing: 8) {
                    ForEach(0..<4) { index in
                        Capsule()
                            .fill(currentPage == index ? AppTheme.yellowAccent : Color.white.opacity(0.3))
                            .frame(width: currentPage == index ? 24 : 10, height: 10)
                            .animation(.easeInOut, value: currentPage)
                    }
                }
                .padding(.bottom, 20)
            }
        }
        // Dismiss keyboard if they tap anywhere outside the text field
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    // MARK: - Individual Pages

    private var pageZero: some View {
        VStack(spacing: 32) {
            GlowingIcon(
                systemName: "hand.wave.fill",
                color: AppTheme.orangeAccent,
                size: 80,
                glowRadius: 20
            )

            Text("Welcome to FoodSave")
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)

            VStack(alignment: .leading, spacing: 8) {
                Text("What should we call you?")
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.7))

                HStack {
                    Image(systemName: "person.circle.fill")
                        .foregroundStyle(.white.opacity(0.5))
                    TextField("Enter your name", text: $nameInput)
                        .textInputAutocapitalization(.words)
                        .submitLabel(.done)
                        .foregroundStyle(.white)
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(nameInput.isEmpty ? Color.white.opacity(0.2) : AppTheme.greenGlow, lineWidth: 2)
                )
            }
            .padding(.horizontal, 32)

            Button("Next") {
                withAnimation { currentPage = 1 }
            }
            .buttonStyle(VibrantButtonStyle(color: AppTheme.greenGlow))
            .padding(.horizontal, 60)
            .disabled(nameInput.trimmingCharacters(in: .whitespaces).isEmpty)
            .opacity(nameInput.trimmingCharacters(in: .whitespaces).isEmpty ? 0.5 : 1.0)
        }
    }

    private func missionPage(icon: String, color: Color, title: String, bodyText: String) -> some View {
        VStack(spacing: 32) {
            GlowingIcon(
                systemName: icon,
                color: color,
                size: 90,
                glowRadius: 22
            )

            Text(title)
                .font(.largeTitle.bold())
                .foregroundStyle(.white)

            Text(bodyText)
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.7))
                .padding(.horizontal, 32)

            Button("Next") {
                withAnimation { currentPage += 1 }
            }
            .buttonStyle(VibrantButtonStyle(color: color))
            .padding(.horizontal, 60)
        }
    }

    private var pageThree: some View {
        VStack(spacing: 32) {
            GlowingIcon(
                systemName: "leaf.circle.fill",
                color: AppTheme.greenGlow,
                size: 90,
                glowRadius: 22
            )

            Text("The Solution")
                .font(.largeTitle.bold())
                .foregroundStyle(.white)

            Text("FoodSave is designed to train your instincts. You'll learn to easily differentiate between what is trash and what is treasure.")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.7))
                .padding(.horizontal, 32)

            Button("Start Saving Food") {
                userName = nameInput.trimmingCharacters(in: .whitespaces)
                hasSeenOnboarding = true
                dismiss()
            }
            .buttonStyle(VibrantButtonStyle(color: AppTheme.greenGlow))
            .padding(.horizontal, 40)
        }
    }
}
