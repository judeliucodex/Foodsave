import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var settings: AppSettings

    // Keys that constitute all user data
    private let userDataKeys = ["hasSeenOnboarding", "userName", "highScore"]

    // Developer mode unlock state (local to this view — not persisted)
    @State private var showDevUnlockAlert = false
    @State private var passwordInput = ""
    @State private var showWrongPasswordAlert = false

    // Simulate new user confirmation
    @State private var showResetConfirmation = false

    // Feedback after reset
    @State private var showResetSuccessBanner = false

    private let devPassword = "igemssc2026"

    var body: some View {
        NavigationView {
            Form {
                // MARK: Preferences
                Section(header: Text("Preferences")) {
                    Toggle("Haptic Feedback", isOn: $settings.isHapticsEnabled)
                }

                // MARK: About
                Section(header: Text("About")) {
                    Text("FoodSave v2.0\nCreated to end food waste.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                // MARK: Developer Mode toggle / unlock
                Section(header: Text("Developer"), footer: Text(settings.isDeveloperMode ? "Developer mode is active." : "Enter a password to unlock developer tools.")) {
                    if settings.isDeveloperMode {
                        Toggle("Developer Mode", isOn: $settings.isDeveloperMode)
                            .tint(.orange)

                        // Simulate new user
                        Button(role: .destructive) {
                            showResetConfirmation = true
                        } label: {
                            Label("Simulate New User", systemImage: "person.badge.minus")
                        }
                        .confirmationDialog(
                            "Reset All User Data?",
                            isPresented: $showResetConfirmation,
                            titleVisibility: .visible
                        ) {
                            Button("Reset & Show Onboarding", role: .destructive) {
                                simulateNewUser()
                            }
                            Button("Cancel", role: .cancel) {}
                        } message: {
                            Text("This will erase your name, high score, and onboarding state — exactly as if the app was freshly installed.")
                        }
                    } else {
                        Button {
                            passwordInput = ""
                            showDevUnlockAlert = true
                        } label: {
                            Label("Unlock Developer Mode", systemImage: "lock.fill")
                                .foregroundStyle(.orange)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") { dismiss() }
            }
            // Password entry alert
            .alert("Developer Mode", isPresented: $showDevUnlockAlert) {
                SecureField("Password", text: $passwordInput)
                Button("Unlock") {
                    if passwordInput == devPassword {
                        settings.isDeveloperMode = true
                    } else {
                        showWrongPasswordAlert = true
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Enter the developer password to unlock developer tools.")
            }
            // Wrong password alert
            .alert("Incorrect Password", isPresented: $showWrongPasswordAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("The password you entered is incorrect.")
            }
            // Success banner overlay
            .overlay(alignment: .top) {
                if showResetSuccessBanner {
                    HStack(spacing: 10) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                        Text("User data cleared. Restart the app to see onboarding.")
                            .font(.footnote.bold())
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(Capsule())
                    .shadow(radius: 6)
                    .padding(.top, 8)
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
        }
    }

    // MARK: - Helpers

    private func simulateNewUser() {
        for key in userDataKeys {
            UserDefaults.standard.removeObject(forKey: key)
        }
        withAnimation {
            showResetSuccessBanner = true
        }
        // Hide banner after 3 seconds then dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation { showResetSuccessBanner = false }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                dismiss()
            }
        }
    }
}
