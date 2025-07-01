# 📱 Habitify

Habitify is a sleek and intuitive iOS habit-tracking application built with **SwiftUI**, **Core Data**, and **Firebase Authentication**. The app helps users develop consistent habits, visualize their progress, and unlock achievements with a motivating user experience.

---

## 🚀 Features

- ✅ **User Authentication**  
  Sign up, sign in, and manage your profile securely using Firebase.

- 📆 **Habit Management**  
  - Add, complete, and delete habits.
  - Categorize habits (e.g. Health, Productivity, Wellness).
  - Mark habits as complete with a single tap.

- 📊 **Progress Tracking**  
  - Weekly stats with progress bars and pie charts.
  - Calendar view to visualize completion dates.
  - Streak tracking for daily consistency.

- 🏆 **Achievements**  
  - Unlock badges based on your habit activity.
  - Toast-style alerts notify you when an achievement is unlocked.

- 🌓 **Dark Mode Support**  
  Toggle between light and dark appearance from the profile section.

- 🔒 **Data Persistence**  
  Data is stored locally using Core Data for offline support.

---

## 📸 Screenshots

| Home | Progress | Achievements | Profile |
|------|----------|--------------|---------|
| ![Home](screenshots/home.png) | ![Progress](screenshots/progress.png) | ![Achievements](screenshots/achievements.png) | ![Profile](screenshots/profile.png) |

---

## 🧰 Tech Stack

- **Language:** Swift  
- **Frameworks:** SwiftUI, Combine, Core Data  
- **Firebase Modules Used:**
  - Authentication

---

## 📦 Installation

1. **Clone the repository**  
   ```bash
   git clone https://github.com/BobKimani/Habitify.git
   cd Habitify
   ```

2. **Open the project in Xcode**
   - Double-click `Habitify.xcodeproj` or `Habitify.xcworkspace` (if using CocoaPods or SwiftPM).

3. **Set up Firebase**
   - Download `GoogleService-Info.plist` from your [Firebase Console](https://console.firebase.google.com/).
   - 
4. **Drag it into the Xcode project under the root directory**
   - Make sure **"Copy items if needed"** is checked.

5. **Run the App**
   - Select an iPhone simulator and press `⌘ + R` (Command + R) to run the app.

---

## 🧪 Requirements

- Xcode **15+**
- iOS **16.0+**
- Swift **5.9+**
- Firebase SDK

---

## 🧠 Architecture

**MVVM (Model-View-ViewModel)**  
- Clear separation of concerns between UI and logic  
- Real-time updates using `@StateObject`, `@ObservedObject`, and `@EnvironmentObject`

**Persistence**  
- Core Data stores habits and habit completions  
- Achievements are managed via a custom Core Data entity

---

## 🙌 Acknowledgements

- [Firebase](https://firebase.google.com/docs/ios/setup) — for authentication
- [Swift Charts](https://developer.apple.com/documentation/charts) — for visual progress indicators
- [Apple SF Symbols](https://developer.apple.com/sf-symbols/) — for intuitive and scalable icons

---
