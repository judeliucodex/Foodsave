# FoodSave Development TODO

## Quick Skip Feature (Testing)
- [x] Update TODO.md with plan
- [x] Add Skip button to GameView.swift header
- [ ] Test: Run in Xcode simulator, use Skip to reach EndView quickly

## Current Status: Starting implementation

- [x] Create TODO.md
- [x] Create FoodItem.swift (model + sample data ~20 items)
- [x] Create FoodsaveApp.swift (App entry point)
- [x] Create ContentView.swift (Home screen: greeting, high score, Play button)
- [x] OnboardingView.swift implementation steps:
  - [x] Step 1: Implement multi-step TabView structure (name, mission, tutorial)
  - [x] Step 2: Add name input with validation/Next button
  - [x] Step 3: Add mission screen content
  - [x] Step 4: Add tutorial swipe demo
  - [x] Step 5: Add Done logic (@AppStorage save, dismiss), animations, preview
- [x] Create GameView.swift (timer, swipe card w/ visuals/haptics/audio, mistake tracking)
- [x] Create FeedbackView.swift (overlay w/ explanation, audio/haptic, pause/resume)
- [x] Create EndView.swift (score summary, high score update, mistake review)
- [ ] Add audio assets (success.mp3, fail.mp3 placeholders)
- [ ] Add SwiftUI previews to all views
- [ ] Test full flows (onboarding -> game -> end)
- [ ] User: Open in Xcode (`open -a Xcode Foodsaveapp/`) and run in Simulator

**Notes**:
- SwiftUI, iOS 17+
- Singleplayer MVP, hardcoded data
- Timer pauses during feedback
- Haptics on swipe commit, audio on feedback
- Scoring: +100 per correct
