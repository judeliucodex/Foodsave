import SwiftUI
import Combine

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("highScore") private var highScore: Int = 0
    @ObservedObject var settings: AppSettings

    // Constants
    private let gameDuration: Int = 60
    private let dragThreshold: CGFloat = 110
    private let baseScore: Int = 100
    private let maxComboMultiplier: Int = 5

    @State private var timeRemaining: Int = 60
    @State private var timerRunning: Bool = true
    @State private var score: Int = 0
    @State private var combo: Int = 0
    @State private var lastPointsEarned: Int = 0

    @State private var currentItem: FoodItem
    @State private var previousItemID: UUID?

    @State private var showFeedback: Bool = false
    @State private var wasCorrect: Bool = false
    @State private var mistakes: [MistakeRecord] = []

    @State private var showReviewScreen: Bool = false
    @State private var showFinalScoreScreen: Bool = false
    @State private var showHint: Bool = false

    @State private var dragOffset: CGSize = .zero
    private let feedbackManager: GameFeedbackManager
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(settings: AppSettings) {
        self.settings = settings
        self.feedbackManager = GameFeedbackManager(settings: settings)
        _currentItem = State(initialValue: FoodItem.sampleData.randomElement() ?? FoodItem.sampleData[0])
    }

    var body: some View {
        ZStack {
            // Vibrant gradient background
            AppTheme.backgroundGradient.ignoresSafeArea()
            FloatingParticles(count: 15)

            VStack(spacing: 20) {
                header

                Spacer()

                cardView(for: currentItem)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("\(currentItem.name), Condition: \(currentItem.details)")
                    .accessibilityHint("Double tap and hold, then swipe right to keep or left to dispose.")

                Spacer()

                Button(action: {
                    timerRunning = false
                    withAnimation { showHint = true }
                }) {
                    HStack {
                        Image(systemName: "magnifyingglass.circle.fill")
                        Text("Analyze Condition")
                    }
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 24)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(Color.cyan.opacity(0.4), lineWidth: 1)
                    )
                    .shadow(color: .cyan.opacity(0.3), radius: 10, y: 4)
                }
                .padding(.bottom, 8)

                Text("Swipe Right = Keep   \u{2022}   Swipe Left = Dispose")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.5))
                    .padding(.bottom, 20)
            }
            .padding()
            .onReceive(timer) { _ in
                guard timerRunning, !showFeedback, !showHint, !showReviewScreen, !showFinalScoreScreen else { return }
                if timeRemaining > 0 { timeRemaining -= 1 }
                if timeRemaining == 0 { handleTimeUp() }
            }

            if showHint { hintPopup }

            if showFeedback {
                FeedbackView(
                    isCorrect: wasCorrect,
                    explanation: currentItem.explanation,
                    pointsEarned: lastPointsEarned,
                    combo: combo
                ) {
                    showFeedback = false
                    timerRunning = true
                    nextItem()
                }
                .transition(.scale.combined(with: .opacity))
                .zIndex(10)
            }
        }
        .navigationTitle("FoodSave")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(showFeedback || showHint)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .fullScreenCover(isPresented: $showReviewScreen) {
            MistakeReviewView(mistakes: mistakes) {
                showReviewScreen = false
                showFinalScoreScreen = true
            }
        }
        .fullScreenCover(isPresented: $showFinalScoreScreen) {
            FinalScoreView(
                finalScore: score,
                playAgainAction: restartGame,
                homeAction: {
                    showFinalScoreScreen = false
                    dismiss()
                }
            )
        }
    }

    private var header: some View {
        HStack {
            // Timer
            HStack(spacing: 6) {
                Image(systemName: "timer")
                    .foregroundStyle(timeRemaining <= 10 ? .red : .white.opacity(0.8))
                Text("\(timeRemaining)s")
                    .font(.title.bold())
                    .foregroundStyle(timeRemaining <= 10 ? .red : .white)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .glassCard(cornerRadius: 16)
            .scaleEffect(timeRemaining <= 10 && timerRunning ? 1.1 : 1.0)
            .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: timeRemaining <= 10 && timerRunning)

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)

                if combo > 1 {
                    Text("\u{1F525} \(min(combo, 5))x COMBO")
                        .font(.caption.bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .shadow(color: .orange.opacity(0.6), radius: 6, y: 2)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }

            if settings.isDeveloperMode {
                Button("End (Test)") {
                    handleTimeUp()
                }
                .font(.caption.bold())
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.red.opacity(0.15))
                .foregroundStyle(.red)
                .clipShape(Capsule())
                .padding(.leading, 8)
            }
        }
    }

    private var hintPopup: some View {
        ZStack {
            Color.black.opacity(0.6).ignoresSafeArea()
            VStack(spacing: 24) {
                GlowingIcon(
                    systemName: "lightbulb.fill",
                    color: AppTheme.yellowAccent,
                    size: 50,
                    glowRadius: 15
                )

                Text("Condition Analysis")
                    .font(.title.bold())
                    .foregroundStyle(.white)

                Text(currentItem.conditionHint)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundStyle(.white.opacity(0.7))

                Button("Got it") {
                    withAnimation { showHint = false }
                    timerRunning = true
                }
                .buttonStyle(VibrantButtonStyle(color: .cyan))
                .padding(.horizontal, 40)
                .padding(.top, 10)
            }
            .padding(32)
            .glassCard(cornerRadius: 32)
            .padding(.horizontal, 30)
            .shadow(radius: 30)
        }
        .zIndex(20)
    }

    @ViewBuilder
    private func cardView(for item: FoodItem) -> some View {
        let overlayColor: Color = dragOffset.width > 0 ? AppTheme.greenGlow : AppTheme.orangeAccent
        let overlayOpacity = min(abs(dragOffset.width) / 120, 0.45)

        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .fill(.ultraThinMaterial)
                .shadow(color: AppTheme.purpleAccent.opacity(0.3), radius: 20, x: 0, y: 10)
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
                                endRadius: 90
                            )
                        )
                        .frame(width: 160, height: 160)
                    Text(item.emoji)
                        .font(.system(size: 100))
                }

                VStack(spacing: 12) {
                    Text(item.name)
                        .font(.system(size: 38, weight: .bold))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)

                    Text(item.details)
                        .font(.title2.weight(.medium))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white.opacity(0.6))
                        .padding(.horizontal)
                }
            }
            .padding(24)

            RoundedRectangle(cornerRadius: 32)
                .fill(overlayColor.opacity(overlayOpacity))

            if dragOffset.width > 20 {
                labelBadge(text: "KEEP", color: AppTheme.greenGlow).offset(x: 100, y: -160)
            } else if dragOffset.width < -20 {
                labelBadge(text: "DISPOSE", color: AppTheme.orangeAccent).offset(x: -100, y: -160)
            }
        }
        .frame(height: 440)
        .padding(.horizontal, 10)
        .offset(dragOffset)
        .rotationEffect(.degrees(Double(dragOffset.width / 20)))
        .gesture(
            DragGesture()
                .onChanged { value in
                    guard !showFeedback, !showHint else { return }
                    dragOffset = value.translation
                }
                .onEnded { value in
                    guard !showFeedback, !showHint else { return }
                    if value.translation.width > 110 {
                        commitDecision(keep: true)
                    } else if value.translation.width < -110 {
                        commitDecision(keep: false)
                    } else {
                        withAnimation(.spring()) { dragOffset = .zero }
                    }
                }
        )
        .animation(.spring(), value: dragOffset)
    }

    private func labelBadge(text: String, color: Color) -> some View {
        Text(text)
            .font(.title3.bold())
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(color)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .shadow(color: color.opacity(0.6), radius: 8)
    }

    private func commitDecision(keep: Bool) {
        wasCorrect = (keep == currentItem.isKeep)
        if wasCorrect {
            combo += 1
            let multiplier = min(combo, 5)
            lastPointsEarned = baseScore * multiplier
            score += lastPointsEarned
            feedbackManager.playSuccess()
        } else {
            combo = 0
            lastPointsEarned = 0
            feedbackManager.playFailure()
            mistakes.append(MistakeRecord(item: currentItem, userChoseKeep: keep))
        }
        withAnimation(.easeOut(duration: 0.2)) { dragOffset = .zero }
        timerRunning = false
        showFeedback = true
    }

    private func nextItem() {
        let pool = FoodItem.sampleData
        var candidate = pool.randomElement() ?? FoodItem.sampleData[0]
        var guardCount = 0
        while candidate.id == previousItemID && guardCount < 10 {
            candidate = pool.randomElement() ?? FoodItem.sampleData[0]
            guardCount += 1
        }
        previousItemID = currentItem.id
        currentItem = candidate
    }

    private func handleTimeUp() {
        timerRunning = false
        if score > highScore { highScore = score }
        if mistakes.isEmpty {
            showFinalScoreScreen = true
        } else {
            showReviewScreen = true
        }
    }

    private func restartGame() {
        timeRemaining = gameDuration
        timerRunning = true
        score = 0
        combo = 0
        lastPointsEarned = 0
        mistakes = []
        showFeedback = false
        showFinalScoreScreen = false
        showReviewScreen = false
        dragOffset = .zero
        nextItem()
    }
}
