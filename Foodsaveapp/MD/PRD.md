# Product Requirements Document (PRD)

**Product Name:** FoodSave
**Platform:** iOS (Mobile)
**Document Status:** Final Draft

---

## 1. Executive Summary
**FoodSave** is an educational, rapid-fire iOS game designed to combat food waste by teaching the public how to make informed food safety and disposal decisions. By gamifying the decision-making process with an intuitive swipe mechanic, the app helps users understand the critical differences between food labels (e.g., "Best Before" vs. "Expiry Date") and debunks common visual misconceptions (e.g., brown spots on bananas).

## 2. Problem Statement
Consumers frequently waste perfectly good food due to a lack of understanding regarding food safety. Key issues include:
* **Label Confusion:** Misunderstanding the difference between safety labels ("Use By" / "Expiry Date") and quality labels ("Best Before").
* **Aesthetic Bias:** Defaulting to throwing food away based on subjective "feel" or appearance rather than actual spoilage (e.g., discarding slightly bruised apples or spotted bananas).

## 3. Target Audience
* **Primary:** Young adults and teenagers who are beginning to purchase and manage their own groceries.
* **Secondary:** General consumers looking to reduce their household food waste and grocery bills.

## 4. Core Gameplay Mechanics
The core loop is a fast-paced, 60-second rapid-fire decision game utilizing a card-swipe interface.
* **The Prompt:** A food item is displayed on a central card alongside specific contextual information (e.g., "Milk - Best Before: 2 days ago").
* **The Action (Swipe):** The user must quickly choose whether to **Keep** (Swipe Right) or **Dispose** (Swipe Left) of the item.
* **The Feedback & Pause:** Immediately after swiping, the **60-second timer strictly pauses**. An overlay appears telling the user if they were Correct or Incorrect, accompanied by a short, educational explanation. The timer only resumes when the user taps "Next" to dismiss the overlay.
* **The Constraint:** The user has exactly one minute of *active play time* to make as many correct decisions as possible.
* **The Review:** At the end of the 60 seconds, users are presented with a summary screen specifically highlighting the items they categorized incorrectly, allowing them to review the explanations again without time pressure.

## 5. User Flow

### 5.1. First-Time Onboarding
1.  **Welcome & Personalization:** A clean welcome screen featuring the FoodSave logo and a text field asking, "What should we call you?" (Saved locally).
2.  **The Mission:** A brief, punchy screen explaining the app's purpose: "Millions of pounds of perfectly good food are thrown away every year. Let's fix that."
3.  **Interactive Tutorial:** A "practice" round with a dummy food card. Animated arrows guide the user to swipe right (Keep) or left (Dispose). The user is forced to complete one swipe to see how the feedback overlay and timer pause work.

### 5.2. Core App Flow
1.  **Home Screen:** Greets the user by name (e.g., "Ready to save food, [Name]?"). Displays "Play Game" button and the user's current "High Score".
2.  **Gameplay Loop:** * 60-second timer begins.
    * Food card + Contextual Info appears.
    * User swipes Left or Right.
    * *Timer pauses.* Feedback overlay appears (Correct/Incorrect + Explanation).
    * User taps "Next". *Timer resumes.* Next card appears.
3.  **End Screen & Review:** * Timer hits 0:00. 
    * App displays the final score and compares it to the High Score.
    * App presents a **"Review Mistakes"** section showing a scrollable list of the food items the user misidentified, their correct answers, and explanations.
    * User can tap "Play Again" or "Home".

## 6. UI/UX & Visual Identity
* **Color Palette:** An eco-friendly, modern palette. Clean off-white/light gray backgrounds to make images pop.
* **Swipe Indicators:** * Dragging **Right**: A green color overlay and a "Keep" icon (like a fridge or checkmark) gradually appear on the card.
    * Dragging **Left**: A red/orange overlay and a "Dispose" icon (like a trash bin) gradually appear.
* **Typography:** Bold, highly legible sans-serif fonts (e.g., SF Pro) to ensure text can be read instantly during rapid gameplay.
* **Imagery:** High-quality, realistic photographs of food in various states (fresh, bruised, spotted, moldy) to accurately convey real-world conditions. Vector art should be avoided for food items.

## 7. Functional Requirements

### 7.1. Food Item Database
A structured local database containing:
* **Image Assets:** Realistic photos.
* **Contextual Text:** Label or condition description.
* **Correct Action:** Boolean value (Keep = True, Dispose = False).
* **Explanation Text:** 1-2 concise sentences explaining *why*.

### 7.2. Game Engine
* **Timer System:** Must reliably pause during feedback and resume immediately upon dismissal.
* **Randomization Engine:** Pulls random food items from the database without repeating the same item consecutively.
* **Scoring System:** Awards points for correct answers (e.g., +100 points). No points deducted or awarded for incorrect answers.
* **Session Tracking:** Temporarily stores an array/list of incorrect answers made during the current session to pass to the final Review Screen.

### 7.3. Local Storage
* Utilizes iOS local storage (e.g., `UserDefaults` or SwiftData) to save the user's Name and their all-time High Score.

## 8. Non-Functional Requirements
* **Performance:** Food images and swipe animations must load and react instantly (60fps) to keep the rapid-fire gameplay smooth and satisfying.
* **Accessibility:** High-contrast text for explanations and clear visual cues (combining colors with distinct icons) for Correct/Incorrect feedback to support colorblind users.
* **Offline Capability:** The entire game, including onboarding and the image database, must be fully playable without an internet connection.