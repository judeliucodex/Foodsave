import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("highScore") private var highScore: Int = 0

    @StateObject private var settings = AppSettings()

    private let poundsPerPoint: Double = 0.05

    @State private var showTutorial: Bool = false
    @State private var showSettings: Bool = false
    @State private var showOnboarding: Bool = false

    var poundsSaved: Double {
        return Double(highScore) * poundsPerPoint
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Vibrant gradient background
                AppTheme.backgroundGradient.ignoresSafeArea()

                // Floating particles
                FloatingParticles(count: 25)

                VStack(spacing: 0) {
                    // Header (Settings only)
                    HStack {
                        Spacer()
                        Button(action: { showSettings = true }) {
                            Image(systemName: "gearshape.fill")
                                .font(.title2)
                                .foregroundStyle(.white.opacity(0.7))
                                .padding(10)
                                .background(Circle().fill(.ultraThinMaterial))
                                .overlay(Circle().stroke(Color.white.opacity(0.15), lineWidth: 1))
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)

                    Spacer()

                    // Impact & Score
                    VStack(spacing: 16) {
                        GlowingIcon(
                            systemName: "leaf.fill",
                            color: AppTheme.greenGlow,
                            size: 70,
                            glowRadius: 25
                        )

                        Text("Ready to save food,\n\(userName.isEmpty ? "Friend" : userName)?")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, 16)

                        // Stats card
                        HStack(spacing: 30) {
                            VStack {
                                Text("High Score")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.6))
                                Text("\(highScore)")
                                    .font(.title2.bold())
                                    .foregroundStyle(.white)
                            }

                            Rectangle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 1, height: 40)

                            VStack {
                                Text("Food Saved (lbs)")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.6))
                                Text(String(format: "%.1f", poundsSaved))
                                    .font(.title2.bold())
                                    .foregroundStyle(AppTheme.greenGlow)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 18)
                        .glassCard(cornerRadius: 20)
                        .padding(.top, 8)
                    }
                    .padding(.horizontal)

                    Spacer()

                    // Actions
                    VStack(spacing: 14) {
                        NavigationLink(destination: GameView(settings: settings)) {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("Play Game")
                            }
                        }
                        .buttonStyle(VibrantButtonStyle(color: AppTheme.greenGlow))

                        HStack(spacing: 12) {
                            NavigationLink(destination: FoodLibraryView()) {
                                HStack {
                                    Image(systemName: "book.fill")
                                    Text("Library")
                                }
                            }
                            .buttonStyle(GlassButtonStyle())

                            Button(action: { showTutorial = true }) {
                                HStack {
                                    Image(systemName: "questionmark.circle.fill")
                                    Text("Tutorial")
                                }
                            }
                            .buttonStyle(GlassButtonStyle())
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 50)
                }
            }
            .fullScreenCover(isPresented: $showOnboarding) {
                OnboardingView()
            }
            .fullScreenCover(isPresented: $showTutorial) {
                TutorialView()
            }
            .sheet(isPresented: $showSettings) {
                SettingsView(settings: settings)
            }
            .onAppear {
                if !hasSeenOnboarding {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showOnboarding = true
                    }
                }
            }
        }
    }
}
