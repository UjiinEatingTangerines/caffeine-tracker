# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Caffeine Half-Life Tracker** - A Flutter mobile app that tracks caffeine intake and calculates when users can sleep based on caffeine half-life (5.5 hours). The app monetizes through AdMob ads with a high revisit rate strategy (4-5 sessions/day).

**Tech Stack:**
- Flutter 3.0+ (Dart 3.0+)
- SQLite (sqflite) for local storage
- AdMob (google_mobile_ads ^4.0.0) for monetization
- Provider for state management
- fl_chart ^0.65.0 for real-time caffeine graphs

**Project Status:** In initial development phase - implementing MVP from planning document

## Project Setup (First Time)

### Step 1: Create Flutter Project
```bash
# Create new Flutter project
flutter create caffeine_tracker
cd caffeine_tracker

# Copy planning document reference
# This directory should already have caffeine_tracker_mvp_plan.md
```

### Step 2: Configure pubspec.yaml
Replace the entire `pubspec.yaml` with:
```yaml
name: caffeine_tracker
description: Track your caffeine intake and sleep better
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # State management
  provider: ^6.1.1

  # Local DB
  sqflite: ^2.3.0
  path: ^1.8.3
  path_provider: ^2.1.1

  # AdMob
  google_mobile_ads: ^4.0.0

  # Charts
  fl_chart: ^0.65.0

  # Date/time
  intl: ^0.18.1

  # UI
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

### Step 3: Install Dependencies
```bash
flutter pub get
```

### Step 4: Create Folder Structure
```bash
# Create all necessary directories
mkdir -p lib/models
mkdir -p lib/screens
mkdir -p lib/widgets
mkdir -p lib/services
mkdir -p lib/constants
```

## Development Commands

### Setup
```bash
flutter doctor                    # Check Flutter installation
flutter create caffeine_tracker   # Create project (if not exists)
flutter pub get                   # Install dependencies
```

### Running
```bash
flutter run                       # Run on connected device/emulator
flutter run -d android            # Run on Android
flutter run -d ios                # Run on iOS simulator (macOS only)

# iOS Simulator (Mac only)
open -a Simulator                 # Open iOS Simulator first
flutter run                       # Then run app

# Real iPhone (Mac + iPhone via USB)
flutter devices                   # Check connected devices
flutter run                       # Install and run on iPhone
```

### Building
```bash
flutter build apk --release       # Build Android APK
flutter build appbundle           # Build Android App Bundle (for Play Store)
flutter build ios --release       # Build iOS (macOS only)
```

### Testing
```bash
flutter test                      # Run unit tests
flutter analyze                   # Run static analysis
```

## Core Architecture

### Data Flow
1. User inputs caffeine intake → `CaffeineEntry` model
2. `DatabaseService` stores entries in SQLite
3. `CaffeineCalculator` computes real-time remaining caffeine using half-life formula: `remaining = initial × 0.5^(hours_elapsed / 5.5)`
4. UI updates every 30 minutes showing body caffeine levels and sleep-ready time
5. `AdManager` shows banner ads (persistent) and interstitial ads (every 3 sessions)

### Key Calculation Logic
The app's core value is the **caffeine half-life calculation**:
- Half-life constant: 5.5 hours
- Sleep threshold: 25mg remaining caffeine
- Formula: `remaining_mg = initial_mg × pow(0.5, hours_elapsed / 5.5)`
- Multiple drinks are summed for total body caffeine

### File Structure (Planned)
```
lib/
├── main.dart                         # App entry + AdMob initialization
├── models/
│   ├── caffeine_entry.dart           # Data model for intake records
│   └── caffeine_calculator.dart      # Half-life calculation logic
├── screens/
│   ├── home_screen.dart              # Real-time graph + current levels
│   ├── add_caffeine_screen.dart      # Input caffeine intake
│   └── history_screen.dart           # Past records
├── widgets/
│   ├── caffeine_realtime_chart.dart  # fl_chart line graph
│   ├── drink_preset_card.dart        # Quick-add preset drinks
│   └── ad_banner_widget.dart         # AdMob banner wrapper
├── services/
│   ├── database_service.dart         # SQLite CRUD operations
│   └── ad_manager.dart               # AdMob banner + interstitial logic
└── constants/
    └── drink_database.dart           # Preset drinks with caffeine amounts
```

## Implementation Roadmap (2 Weeks)

Follow this order for MVP development:

### Week 1: Core Features
**Day 1-2: Data Models & Logic**
1. `lib/models/caffeine_entry.dart` - Data model with fromMap/toMap
2. `lib/models/caffeine_calculator.dart` - Half-life calculation logic
3. `lib/constants/drink_database.dart` - Preset drinks list

**Day 3-4: UI Foundation**
1. `lib/main.dart` - App entry point (without AdMob first)
2. `lib/screens/home_screen.dart` - Main screen layout
3. `lib/widgets/caffeine_realtime_chart.dart` - fl_chart implementation

**Day 5-6: Database**
1. `lib/services/database_service.dart` - SQLite CRUD operations
2. Connect home screen to database
3. Test data persistence

**Day 7: AdMob Integration**
1. `lib/services/ad_manager.dart` - Ad management
2. `lib/widgets/ad_banner_widget.dart` - Banner widget
3. Configure AndroidManifest.xml and Info.plist
4. Update main.dart with AdMob initialization

### Week 2: Completion
**Day 8-9: Input Screen**
1. `lib/screens/add_caffeine_screen.dart` - Add intake screen
2. `lib/widgets/drink_preset_card.dart` - Preset drink cards

**Day 10-11: History & Polish**
1. `lib/screens/history_screen.dart` - Past records
2. UI/UX improvements
3. Dark mode (optional)

**Day 12-13: Testing & Bug Fixes**
1. Full app testing
2. Performance optimization
3. Error handling

**Day 14: Release Prep**
1. App icon
2. Screenshots
3. Store descriptions
4. Privacy policy

## AdMob Configuration

### Android Setup
Edit `android/app/src/main/AndroidManifest.xml`:

Add inside `<application>` tag, BEFORE the `<activity>` tag:
```xml
<!-- AdMob App ID -->
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-3940256099942544~3347511713"/>
```

**IMPORTANT:** This is a TEST ID. Before release, replace with your real AdMob App ID from AdMob console.

### iOS Setup
Edit `ios/Runner/Info.plist`:

Add inside the `<dict>` tag:
```xml
<!-- AdMob App ID -->
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-3940256099942544~1458002511</string>

<!-- App Tracking Transparency (iOS 14+) -->
<key>NSUserTrackingUsageDescription</key>
<string>This app uses your data to provide personalized ads.</string>
```

**IMPORTANT:** This is a TEST ID. Before release, replace with your real AdMob App ID.

### Ad Unit IDs (for ad_manager.dart)

**Android Test IDs:**
- Banner: `ca-app-pub-3940256099942544/6300978111`
- Interstitial: `ca-app-pub-3940256099942544/1033173712`

**iOS Test IDs:**
- Banner: `ca-app-pub-3940256099942544/2934735716`
- Interstitial: `ca-app-pub-3940256099942544/4411468910`

### Ad Strategy
- **Banner ads**: Always visible at bottom of screens
- **Interstitial ads**: Show every 3 sessions AND minimum 5 minutes apart
- **Test IDs**: Use Google's test ad unit IDs during development (see above)
- **Production IDs**: Replace with real AdMob IDs before release

## Critical Implementation Notes

### Caffeine Calculation
- Generate graph points every 30 minutes for smooth curves
- Support multiple simultaneous caffeine sources (coffee + energy drink)
- Include past 6 hours and future 12 hours in graph display
- Sleep time calculation uses binary search to find when total < 25mg

### Database Schema
SQLite table `caffeine_entries`:
- `id` TEXT PRIMARY KEY
- `drinkName` TEXT
- `amount` REAL (caffeine in mg)
- `timestamp` TEXT (ISO8601 format)

### Preset Drinks Database
Common drinks with typical caffeine content:
- Americano (Tall): 150mg
- Cold Brew: 200mg
- Red Bull (250ml): 80mg
- Espresso shot: 63mg
(See full list in planning document)

## Legal Requirements

### Disclaimer (MUST INCLUDE)
Display prominently in app and store listing:
```
⚠️ This app provides reference information only and is not medical advice or a diagnostic tool.
If you have sleep disorders, please consult a healthcare professional.
```

### Privacy Policy
- App collects ONLY: AdMob advertising ID, local usage data
- All caffeine data stored locally on device (not uploaded)
- No personal information (email, name) collected

## Monetization Strategy

### Target Metrics
- 4-5 sessions/day/user (morning coffee, lunch, afternoon, evening check, bedtime)
- Session duration: ~1.5 minutes
- DAU target: 1,000 users = $200-300/month revenue

### User Retention Triggers
- Push notification: "Check your caffeine levels before coffee!"
- Widget (v2.0): Show current caffeine on home screen
- Psychological hook: "If you drink coffee now, you can't sleep until XX:XX"

## Implementation Guidelines

### When Implementing Each File

**models/caffeine_entry.dart:**
- Include `id`, `drinkName`, `amount` (mg), `timestamp` fields
- Implement `toMap()` and `fromMap()` for SQLite serialization
- Use `DateTime.toIso8601String()` for timestamp storage

**models/caffeine_calculator.dart:**
- Use `dart:math` for `pow()` function
- Half-life constant: 5.5 hours
- Sleep threshold: 25.0 mg
- Generate chart points at 30-minute intervals
- Include past 6 hours and future 12 hours in chart data

**constants/drink_database.dart:**
- Create `DrinkPreset` class with name, caffeineAmount, emoji
- List 10 common drinks with accurate caffeine content
- Use emojis for visual appeal (☕🥛🧊🔋⚡👹🥤🍵🫖)

**services/database_service.dart:**
- Table name: `caffeine_entries`
- Use singleton pattern for database instance
- Implement CRUD: create, read, readToday, delete
- Handle database initialization in `initDatabase()`
- Use `path_provider` to get database path

**services/ad_manager.dart:**
- Use Platform.isAndroid/isIOS to return correct ad unit IDs
- Implement session counter for interstitial ads (every 3rd session)
- Preload next interstitial ad after showing one
- Add 5-minute minimum interval between interstitial ads

**widgets/ad_banner_widget.dart:**
- StatefulWidget to manage ad lifecycle
- Load ad in `initState()`
- Dispose ad in `dispose()`
- Show placeholder (SizedBox) while loading

**widgets/caffeine_realtime_chart.dart:**
- Use `fl_chart` package's `LineChart` widget
- Plot caffeine decay curve using data from `CaffeineCalculator.generateCurve()`
- Show horizontal line at 25mg (sleep threshold)
- X-axis: time, Y-axis: caffeine in mg

**screens/home_screen.dart:**
- Display current caffeine level prominently (large font)
- Show sleep-ready time calculation
- Gradient background (orange/red for high, blue/green for low)
- Floating action button to add caffeine
- Include `AdBannerWidget` at bottom
- Call `AdManager.showInterstitialAdIfNeeded()` in `initState()`

**screens/add_caffeine_screen.dart:**
- Grid of preset drink cards
- Custom input option
- DateTimePicker for intake time (default: now)
- Save to database and pop back to home screen

**screens/history_screen.dart:**
- ListView of past entries (grouped by date)
- Swipe to delete functionality
- Show total caffeine per day

**main.dart:**
- Initialize AdMob in `main()` before `runApp()`
- Use `WidgetsFlutterBinding.ensureInitialized()`
- Preload first interstitial ad
- Set Material 3 theme with brown primary color
- Disable debug banner

## Development Warnings

1. **Never call this a medical app** - regulatory issues
2. **Ad frequency limits** - too many ads = user churn (max 3-session intervals)
3. **Offline-first** - all features must work without internet
4. **No server costs** - local SQLite only, no backend
5. **Individual variation** - half-life varies by person, include disclaimer
6. **Copyright-free content** - use only pharmacological formulas (public knowledge) and Material Design
7. **Test with real devices** - AdMob requires physical device or emulator with Google Play Services
8. **Don't commit test data** - Clear sample data before production builds

## Code Reference Location

**ALL implementation code examples are in `caffeine_tracker_mvp_plan.md`** under section "🧬 핵심 코드":

1. **Caffeine Calculator** (models/caffeine_calculator.dart) - Lines 235-350
2. **Drink Database** (constants/drink_database.dart) - Lines 354-379
3. **AdMob Manager** (services/ad_manager.dart) - Lines 383-452
4. **Home Screen** (screens/home_screen.dart) - Lines 456-595
5. **Ad Banner Widget** (widgets/ad_banner_widget.dart) - Lines 599-662
6. **Main App Entry** (main.dart) - Lines 666-700

**Copy these code blocks directly when implementing each file.** They are production-ready and follow the exact specifications.

## Before Starting Development

**Pre-flight Checklist:**
- [ ] Flutter SDK installed (`flutter doctor` shows no errors)
- [ ] Android Studio or VS Code with Flutter extensions installed
- [ ] At least one emulator/simulator configured OR physical device connected
- [ ] Read through `caffeine_tracker_mvp_plan.md` sections:
  - [ ] 프로젝트 개요 (Project Overview)
  - [ ] 기술 스택 (Tech Stack)
  - [ ] 핵심 코드 (Core Code) - lines 233-700
  - [ ] MVP 개발 로드맵 (Development Roadmap)
- [ ] Understand the caffeine half-life formula: `remaining = initial × 0.5^(hours_elapsed / 5.5)`
- [ ] Review AdMob test IDs (don't use production IDs yet)

## Common Issues & Solutions

**Issue: AdMob ads not showing**
- Solution: Ads don't work on iOS Simulator, use real device
- Solution: Wait 1-2 minutes after first launch for test ads to load
- Solution: Check Google Play Services is installed on emulator

**Issue: SQLite database not persisting**
- Solution: Make sure `path_provider` package is added
- Solution: Check database initialization happens before first query
- Solution: Use `getDatabasesPath()` not hardcoded path

**Issue: Chart not rendering**
- Solution: Ensure `fl_chart` version matches (^0.65.0)
- Solution: Wrap chart in `Expanded` or `SizedBox` with fixed height
- Solution: Check data points are not empty or null

**Issue: Build fails on iOS**
- Solution: Run `pod install` in `ios/` directory
- Solution: Update `ios/Podfile` minimum iOS version to 11.0
- Solution: Clean build: `flutter clean && flutter pub get`

## Testing Strategy

### Quick Start Testing Guide

**See detailed testing guides:**
- 📄 **TESTING_GUIDE.md** - Complete testing guide (all platforms)
- 📄 **TESTING_IOS.md** - iOS-specific guide for Mac + iPhone users

### iOS Testing (Mac + iPhone Setup)

**Option 1: iOS Simulator (Mac only) - Fastest**
```bash
# Install Flutter
brew install flutter

# Open Simulator
open -a Simulator

# Run app
cd caffeine_tracker
flutter pub get
flutter run
```

**Pros:** ✅ Fast, ✅ Hot reload, ✅ No device needed
**Cons:** ❌ AdMob ads don't show (simulator limitation)

**Option 2: Real iPhone - For AdMob Testing**
```bash
# Connect iPhone via USB
# Trust computer on iPhone

# Check connection
flutter devices

# Run app
flutter run
```

**First time setup:**
1. Open Xcode: `open ios/Runner.xcworkspace`
2. Select **Runner** → **Signing & Capabilities**
3. Choose your Apple ID in **Team**
4. Change **Bundle Identifier** to unique ID (e.g., `com.yourname.caffeinetracker`)
5. On iPhone: Settings → General → VPN & Device Management → Trust your Apple ID

**Pros:** ✅ AdMob ads work, ✅ Real performance
**Cons:** ⚠️ Requires Xcode setup, ⚠️ Free apps expire after 7 days (re-run to reinstall)

**IMPORTANT:** AdMob ads **NEVER** show in iOS Simulator - always test on real iPhone!

### Android Testing

**Option 1: Android Emulator**
- Install Android Studio
- Create AVD (Android Virtual Device)
- `flutter run`

**Option 2: Real Android Device**
- Enable Developer Options + USB Debugging
- Connect via USB
- `flutter run`

### Manual Testing Checklist

1. **Caffeine Calculation Test:**
   - Add coffee (150mg) at specific time
   - Wait 5 minutes, check remaining caffeine decreased
   - Verify graph shows exponential decay curve

2. **Database Persistence Test:**
   - Add 3 drinks
   - Close and restart app
   - Verify all 3 drinks still show up

3. **Ad Display Test (Real device only!):**
   - Launch app 3 times (should see interstitial on 3rd launch)
   - Check banner ad appears at bottom
   - Wait 1-2 minutes for ads to load
   - Verify ads don't overlap with content

4. **Offline Test:**
   - Enable airplane mode
   - Add drinks, view history
   - Verify all features work (ads may not load, that's OK)

### Unit Testing (Optional for MVP)
```bash
flutter test
```
Focus on testing `CaffeineCalculator` logic:
- Test `calculateRemaining()` with known values
- Test `calculateSleepTime()` edge cases (0 caffeine, high caffeine)

### Platform-Specific Notes

**iOS:**
- AdMob ads require **real device** (not simulator)
- Free Apple ID: apps expire after 7 days
- Apple Developer ($99/yr): no expiration + TestFlight + App Store

**Android:**
- AdMob ads work on emulator (with Google Play Services)
- No signing needed for testing
- Can install APK directly on device

## Release Checklist

Before deploying:
- [ ] Replace AdMob test IDs with production IDs in `ad_manager.dart`
- [ ] Update AndroidManifest.xml and Info.plist with production AdMob App IDs
- [ ] Add disclaimer to app (Settings screen or About dialog)
- [ ] Create privacy policy page (can be simple text screen)
- [ ] Generate app icon (1024x1024) - use Figma or Canva
- [ ] Capture 5 screenshots for store listing (Pixel 5 or iPhone 13 resolution)
- [ ] Test offline functionality
- [ ] Verify app works on both Android/iOS
- [ ] Check app size < 50MB (`flutter build apk --release` and check size)
- [ ] Get feedback from 5+ test users
- [ ] Remove any TODO comments from code
- [ ] Set version to 1.0.0 in pubspec.yaml
- [ ] Build release: `flutter build appbundle --release` (Android)

## ASO Keywords

**English**: caffeine tracker, sleep better, insomnia, coffee tracker, caffeine calculator
**Korean**: 카페인, 불면증, 수면, 커피, 트래커

Target communities: r/insomnia, r/decaf, productivity forums, medical student communities

## Next Steps After MVP

See `caffeine_tracker_mvp_plan.md` section "🔧 추가 개발 아이디어 (v2.0+)" for:
- Premium features (ad removal, custom half-life)
- Social features (caffeine ranking)
- Health app integration (Apple Health, Google Fit)
- AI recommendations (TensorFlow Lite)
