# ☕ Caffeine Half-Life Tracker

A Flutter mobile app that tracks caffeine intake and calculates when you can sleep based on caffeine half-life (5.5 hours).

## 🎯 Features

- **Real-time Caffeine Tracking**: Track your body's current caffeine levels in real-time
- **Sleep Time Calculator**: Know exactly when you can sleep based on your caffeine intake
- **Caffeine Half-Life Formula**: Uses the scientifically accurate 5.5-hour half-life calculation
- **Preset Drinks Database**: Quick-add common drinks (Americano, Energy drinks, etc.)
- **Local SQLite Storage**: All data stored locally - works offline
- **AdMob Monetization**: Banner and interstitial ads for revenue generation

## 🧮 Core Calculation

**Half-life Formula:**
```
remaining_caffeine = initial_amount × 0.5^(hours_elapsed / 5.5)
```

- **Half-life**: 5.5 hours
- **Sleep Threshold**: 25mg remaining caffeine

## 🛠️ Tech Stack

- **Framework**: Flutter 3.0+
- **Language**: Dart 3.0+
- **Database**: SQLite (sqflite)
- **State Management**: Provider
- **Charts**: fl_chart ^0.65.0
- **Ads**: Google AdMob

## 📦 Dependencies

```yaml
dependencies:
  provider: ^6.1.1
  sqflite: ^2.3.0
  path: ^1.8.3
  path_provider: ^2.1.1
  google_mobile_ads: ^4.0.0
  fl_chart: ^0.65.0
  intl: ^0.18.1
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.0+
- Android Studio or VS Code with Flutter extensions
- Physical device or emulator with Google Play Services (for AdMob)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/UjiinEatingTangerines/caffeine_tracker.git
cd caffeine_tracker
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 📱 Building

### Android
```bash
flutter build apk --release
flutter build appbundle --release  # For Play Store
```

### iOS
```bash
flutter build ios --release
```

## ⚠️ Legal Disclaimer

This app provides **reference information only** and is not medical advice or a diagnostic tool. If you have sleep disorders, please consult a healthcare professional.

## 📊 Project Structure

```
lib/
├── main.dart                         # App entry + AdMob initialization
├── models/
│   ├── caffeine_entry.dart           # Data model for intake records
│   └── caffeine_calculator.dart      # Half-life calculation logic
├── screens/
│   └── home_screen.dart              # Main screen
├── widgets/
│   └── ad_banner_widget.dart         # AdMob banner wrapper
├── services/
│   ├── database_service.dart         # SQLite CRUD operations
│   └── ad_manager.dart               # AdMob banner + interstitial logic
└── constants/
    └── drink_database.dart           # Preset drinks with caffeine amounts
```

## 🎯 Roadmap

### MVP (Current)
- [x] Core caffeine calculation logic
- [x] SQLite local storage
- [x] Home screen with current caffeine levels
- [x] AdMob integration (banner ads)
- [ ] Add caffeine screen with preset drinks
- [ ] History screen
- [ ] Real-time chart visualization

### v2.0 (Future)
- [ ] Premium features (ad removal, custom half-life)
- [ ] Widget support (home screen caffeine display)
- [ ] Push notifications
- [ ] Apple Health / Google Fit integration
- [ ] Social features (caffeine ranking)

## 💰 Monetization Strategy

- **Banner Ads**: Always visible at bottom of screens
- **Interstitial Ads**: Every 3 sessions, minimum 5 minutes apart
- **Target**: 4-5 sessions/day/user
- **Revenue Target**: $200-300/month with 1,000 DAU

## 🧪 Testing

Run tests:
```bash
flutter test
```

Run static analysis:
```bash
flutter analyze
```

## 📄 License

MIT License - see LICENSE file for details

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Contact

- GitHub: [@UjiinEatingTangerines](https://github.com/UjiinEatingTangerines)

---

**⚠️ Note**: This app uses AdMob test IDs during development. Replace with production IDs before release.

Built with ❤️ using Flutter
