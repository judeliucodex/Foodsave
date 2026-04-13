// Shared theme for FoodSave — vibrant game-like UI

import SwiftUI

// MARK: - App Theme

enum AppTheme {

    // MARK: Gradients

    static let backgroundGradient = LinearGradient(
        colors: [
            Color(red: 0.12, green: 0.05, blue: 0.30),
            Color(red: 0.08, green: 0.10, blue: 0.42),
            Color(red: 0.05, green: 0.12, blue: 0.32)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let cardGradient = LinearGradient(
        colors: [
            Color.white.opacity(0.15),
            Color.white.opacity(0.05)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let greenGlow = Color(red: 0.2, green: 0.9, blue: 0.4)
    static let purpleAccent = Color(red: 0.55, green: 0.3, blue: 1.0)
    static let yellowAccent = Color(red: 1.0, green: 0.85, blue: 0.2)
    static let orangeAccent = Color(red: 1.0, green: 0.5, blue: 0.2)
}

// MARK: - Glassmorphism Card Modifier

struct GlassCard: ViewModifier {
    var cornerRadius: CGFloat = 24

    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
    }
}

extension View {
    func glassCard(cornerRadius: CGFloat = 24) -> some View {
        modifier(GlassCard(cornerRadius: cornerRadius))
    }
}

// MARK: - Gradient Background Modifier

struct GradientBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    AppTheme.backgroundGradient

                    // Subtle radial glow at top
                    RadialGradient(
                        colors: [
                            Color.purple.opacity(0.3),
                            Color.clear
                        ],
                        center: .topTrailing,
                        startRadius: 50,
                        endRadius: 400
                    )

                    RadialGradient(
                        colors: [
                            Color.blue.opacity(0.2),
                            Color.clear
                        ],
                        center: .bottomLeading,
                        startRadius: 50,
                        endRadius: 350
                    )
                }
                .ignoresSafeArea()
            )
    }
}

extension View {
    func gradientBackground() -> some View {
        modifier(GradientBackground())
    }
}

// MARK: - Floating Particles View

struct FloatingParticles: View {
    let particleCount: Int

    init(count: Int = 20) {
        self.particleCount = count
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0..<particleCount, id: \.self) { index in
                    ParticleDot(
                        screenSize: geo.size,
                        index: index
                    )
                }
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}

private struct ParticleDot: View {
    let screenSize: CGSize
    let index: Int

    @State private var yOffset: CGFloat = 0
    @State private var opacity: Double = 0

    private var size: CGFloat {
        CGFloat.random(in: 3...8)
    }

    private var xPosition: CGFloat {
        // Deterministic but varied x position based on index
        let seed = Double(index) * 137.508 // golden angle
        return CGFloat(seed.truncatingRemainder(dividingBy: Double(max(screenSize.width, 1))))
    }

    private var initialY: CGFloat {
        let seed = Double(index) * 97.31
        return CGFloat(seed.truncatingRemainder(dividingBy: Double(max(screenSize.height, 1))))
    }

    private var duration: Double {
        Double.random(in: 8...16)
    }

    private var particleColor: Color {
        let colors: [Color] = [
            .white,
            .cyan.opacity(0.8),
            .purple.opacity(0.6),
            .yellow.opacity(0.5)
        ]
        return colors[index % colors.count]
    }

    var body: some View {
        Circle()
            .fill(particleColor)
            .frame(width: size, height: size)
            .position(x: xPosition, y: initialY + yOffset)
            .opacity(opacity)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: duration)
                    .repeatForever(autoreverses: true)
                ) {
                    yOffset = -CGFloat.random(in: 30...80)
                    opacity = Double.random(in: 0.2...0.6)
                }
            }
    }
}

// MARK: - Glowing Icon Background

struct GlowingIcon: View {
    let systemName: String
    let color: Color
    var size: CGFloat = 70
    var glowRadius: CGFloat = 20

    var body: some View {
        ZStack {
            Circle()
                .fill(color.opacity(0.25))
                .frame(width: size * 2.2, height: size * 2.2)
                .blur(radius: glowRadius)

            Circle()
                .fill(
                    RadialGradient(
                        colors: [color.opacity(0.3), color.opacity(0.1)],
                        center: .center,
                        startRadius: 0,
                        endRadius: size * 1.1
                    )
                )
                .frame(width: size * 2, height: size * 2)

            Image(systemName: systemName)
                .font(.system(size: size))
                .foregroundStyle(color)
                .shadow(color: color.opacity(0.5), radius: 10)
        }
    }
}

// MARK: - Vibrant Button Style

struct VibrantButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3.bold())
            .foregroundStyle(.white)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(color)
                    .shadow(color: color.opacity(0.5), radius: configuration.isPressed ? 5 : 15, y: configuration.isPressed ? 2 : 8)
            )
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Secondary Glass Button Style

struct GlassButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(.ultraThinMaterial)
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.25), lineWidth: 1)
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}
