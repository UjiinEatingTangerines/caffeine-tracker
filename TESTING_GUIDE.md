# 🧪 Caffeine Tracker - 테스트 가이드

배포 전에 앱을 확인하는 모든 방법을 정리한 문서입니다.

---

## 1️⃣ Flutter 설치 및 로컬 실행 (가장 권장)

### Step 1: Flutter SDK 설치

**macOS 기준:**

```bash
# Homebrew로 설치 (가장 쉬움)
brew install flutter

# 또는 공식 방법
cd ~
git clone https://github.com/flutter/flutter.git -b stable
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# 설치 확인
flutter doctor
```

**예상 출력:**
```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.x.x)
[✓] Android toolchain - develop for Android devices
[✓] Xcode - develop for iOS and macOS
[✓] Chrome - develop for the web
[✓] Android Studio
[✓] VS Code
[✓] Connected device
```

### Step 2: Android Studio 설치 (Android 테스트용)

1. https://developer.android.com/studio 에서 다운로드
2. 설치 후 실행
3. SDK Manager에서 Android SDK 설치
4. AVD Manager에서 에뮬레이터 생성
   - 추천: Pixel 5, Android 12 (API 31)

### Step 3: 프로젝트 의존성 설치

```bash
cd caffeine_tracker
flutter pub get
```

**예상 출력:**
```
Running "flutter pub get" in caffeine_tracker...
Resolving dependencies... (5.2s)
+ provider 6.1.1
+ sqflite 2.3.0
+ google_mobile_ads 4.0.0
+ fl_chart 0.65.0
... (모든 패키지 설치)
✓ Done!
```

### Step 4: 앱 실행

**Android 에뮬레이터에서:**
```bash
# 에뮬레이터 실행 (Android Studio AVD Manager에서)
# 또는 명령어로:
flutter emulators --launch <emulator-id>

# 앱 실행
flutter run
```

**실제 Android 디바이스에서:**
```bash
# 1. 디바이스 설정:
#    - 개발자 옵션 활성화
#    - USB 디버깅 활성화
#    - USB로 연결

# 2. 디바이스 확인
flutter devices

# 3. 앱 실행
flutter run
```

**iOS 시뮬레이터에서 (macOS만 가능):**
```bash
# 시뮬레이터 실행
open -a Simulator

# 앱 실행
flutter run
```

### Step 5: Hot Reload로 빠른 개발

앱 실행 중:
- `r` 입력 → Hot reload (UI 변경사항 즉시 반영)
- `R` 입력 → Hot restart (전체 재시작)
- `q` 입력 → 종료

---

## 2️⃣ APK 빌드 후 실제 디바이스에 설치

Flutter 설치 없이 **Android 디바이스만 있으면** 가능합니다.

### Step 1: APK 빌드 (Flutter 설치 필요)

```bash
cd caffeine_tracker

# Debug APK 빌드 (테스트용)
flutter build apk --debug

# 빌드된 파일 위치:
# build/app/outputs/flutter-apk/app-debug.apk
```

### Step 2: 실제 디바이스에 설치

**방법 1: ADB로 설치**
```bash
# ADB 설치 확인
adb version

# 디바이스 연결 확인
adb devices

# APK 설치
adb install build/app/outputs/flutter-apk/app-debug.apk
```

**방법 2: 파일 전송 후 수동 설치**
1. APK 파일을 Google Drive/Dropbox/이메일로 전송
2. 디바이스에서 다운로드
3. 디바이스 설정에서:
   - 보안 → "알 수 없는 출처" 허용
4. APK 파일 탭 → 설치

---

## 3️⃣ 코드 정적 분석 (Flutter 실행 없이 확인)

### Dart Analyzer로 문법 오류 확인

```bash
cd caffeine_tracker

# 정적 분석 실행
flutter analyze
```

**예상 출력 (정상):**
```
Analyzing caffeine_tracker...
No issues found!
```

**오류가 있다면:**
```
error • lib/screens/home_screen.dart:45:10 • Undefined name 'foo'
warning • lib/main.dart:12:5 • Unused import
```

### Dart Formatter로 코드 스타일 확인

```bash
# 모든 파일 포맷팅
dart format lib/

# 특정 파일만
dart format lib/main.dart
```

---

## 4️⃣ 단위 테스트 실행

### 테스트 작성 예시

**test/caffeine_calculator_test.dart** 생성:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:caffeine_tracker/models/caffeine_calculator.dart';
import 'package:caffeine_tracker/models/caffeine_entry.dart';

void main() {
  group('CaffeineCalculator', () {
    test('calculateRemaining - 5.5시간 후 절반이어야 함', () {
      final consumedAt = DateTime.now().subtract(Duration(hours: 5, minutes: 30));
      final remaining = CaffeineCalculator.calculateRemaining(100, consumedAt);

      // 100mg → 50mg (오차 ±5mg)
      expect(remaining, closeTo(50, 5));
    });

    test('calculateSleepTime - 카페인 없으면 지금 가능', () {
      final sleepTime = CaffeineCalculator.calculateSleepTime([]);
      final now = DateTime.now();

      expect(sleepTime!.difference(now).inMinutes, lessThan(1));
    });

    test('calculateTotalRemaining - 여러 섭취 합산', () {
      final entries = [
        CaffeineEntry(
          id: '1',
          drinkName: 'Coffee 1',
          amount: 100,
          timestamp: DateTime.now().subtract(Duration(hours: 2)),
        ),
        CaffeineEntry(
          id: '2',
          drinkName: 'Coffee 2',
          amount: 100,
          timestamp: DateTime.now().subtract(Duration(hours: 1)),
        ),
      ];

      final total = CaffeineCalculator.calculateTotalRemaining(entries);

      // 2시간 전 100mg + 1시간 전 100mg > 100mg
      expect(total, greaterThan(100));
    });
  });
}
```

### 테스트 실행

```bash
# 모든 테스트 실행
flutter test

# 특정 파일만
flutter test test/caffeine_calculator_test.dart

# 커버리지 리포트 생성
flutter test --coverage
```

---

## 5️⃣ 브라우저에서 미리보기 (제한적)

Flutter Web으로 간단히 확인 (AdMob 광고는 안 됨):

```bash
flutter run -d chrome
```

**주의사항:**
- AdMob 광고 표시 안 됨
- SQLite 대신 IndexedDB 사용
- 모바일 UI 경험과 다름

---

## 6️⃣ 체크리스트 기반 수동 테스트

### 기능 테스트 체크리스트

```
□ 앱 시작
  □ 로딩 화면 없이 바로 홈 화면 표시
  □ 초기 상태: "체내 카페인 0mg"
  □ 배너 광고 하단에 표시 (1-2분 대기)

□ 카페인 추가
  □ "카페인 추가" 버튼 탭
  □ 프리셋 음료 그리드 표시 (10개)
  □ 프리셋 탭 → 자동 입력
  □ 커스텀 입력 가능
  □ 시간 선택 가능
  □ "추가하기" 버튼 → 홈 화면 복귀
  □ 추가한 음료가 리스트에 표시

□ 카페인 계산
  □ 현재 카페인 양 정확히 표시
  □ 잔류량이 시간에 따라 감소 (새로고침 후)
  □ "잠들 수 있는 시간" 표시
  □ 카페인 높으면 빨강/주황 그라데이션
  □ 카페인 낮으면 파랑/초록 그라데이션

□ 히스토리
  □ 히스토리 아이콘 탭
  □ 날짜별로 그룹핑
  □ 스와이프로 삭제 가능
  □ 날짜별 총 카페인 표시

□ 데이터 영속성
  □ 앱 종료 후 재시작 → 데이터 유지
  □ 디바이스 재부팅 후 → 데이터 유지

□ 광고
  □ 배너 광고: 모든 화면 하단
  □ 전면 광고: 3번째 세션에 표시
  □ 광고 로드 실패해도 앱 정상 동작

□ 오프라인
  □ 비행기 모드 활성화
  □ 모든 기능 정상 동작
  □ 광고만 로드 안 됨

□ 성능
  □ 앱 시작 3초 이내
  □ 화면 전환 부드럽게
  □ 스크롤 끊김 없음
```

### 버그 발견 시 기록 템플릿

```markdown
## 버그 보고

**재현 단계:**
1.
2.
3.

**예상 동작:**


**실제 동작:**


**스크린샷/에러 로그:**


**환경:**
- 디바이스:
- Android/iOS 버전:
```

---

## 7️⃣ 배포 전 최종 체크리스트

### 코드 체크
```bash
# 1. 정적 분석 통과
flutter analyze
# → "No issues found!"

# 2. 모든 테스트 통과
flutter test
# → "All tests passed!"

# 3. 빌드 성공
flutter build apk --release
# → "✓ Built build/app/outputs/flutter-apk/app-release.apk"
```

### 설정 체크
```
□ pubspec.yaml
  □ version: 1.0.0+1
  □ 모든 의존성 최신 버전

□ lib/services/ad_manager.dart
  □ AdMob ID가 테스트 ID인지 확인
  □ 프로덕션 배포 시 실제 ID로 교체 필요

□ AndroidManifest.xml
  □ AdMob App ID 설정됨
  □ 인터넷 권한 있음

□ Info.plist (iOS)
  □ GADApplicationIdentifier 설정됨
  □ NSUserTrackingUsageDescription 있음

□ 법적 요구사항
  □ 면책 조항 UI에 표시
  □ 개인정보처리방침 페이지 있음
```

### 실제 디바이스 테스트
```
□ 3개 이상의 다른 Android 디바이스에서 테스트
□ 다양한 화면 크기에서 UI 확인
□ 저사양 디바이스에서 성능 확인
□ 실제 AdMob 광고 표시 확인
□ 5명 이상의 테스터에게 피드백 받기
```

### 앱 크기 확인
```bash
# APK 크기 확인
ls -lh build/app/outputs/flutter-apk/app-release.apk

# 목표: < 50MB
```

---

## 8️⃣ 문제 해결 (Troubleshooting)

### 문제: "flutter: command not found"
```bash
# Flutter PATH 확인
echo $PATH | grep flutter

# PATH에 추가
export PATH="$PATH:$HOME/flutter/bin"
source ~/.zshrc
```

### 문제: "Gradle build failed"
```bash
# Android Studio에서:
# File → Invalidate Caches / Restart

# 또는 명령어로:
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### 문제: "AdMob 광고가 안 나와요"
- iOS Simulator에서는 광고 안 나옴 → 실제 디바이스 사용
- 첫 실행 후 1-2분 대기
- AndroidManifest.xml과 Info.plist에 App ID 확인
- 인터넷 연결 확인

### 문제: "SQLite 데이터가 안 저장돼요"
```bash
# 앱 데이터 초기화 후 재테스트
flutter clean
flutter run
```

### 문제: "빌드는 되는데 실행이 안 돼요"
```bash
# 전체 재빌드
flutter clean
flutter pub get
flutter run
```

---

## 9️⃣ 추천 테스트 흐름

### 첫 테스트 (30분)
1. ✅ Flutter 설치
2. ✅ `flutter doctor` 실행
3. ✅ 에뮬레이터 설정
4. ✅ `flutter run` 실행
5. ✅ 기본 동작 확인 (카페인 추가, 계산)

### 전체 테스트 (2시간)
1. ✅ 모든 기능 체크리스트 실행
2. ✅ 실제 디바이스에서 테스트
3. ✅ 오프라인 모드 테스트
4. ✅ 광고 표시 확인
5. ✅ 데이터 영속성 확인

### 배포 전 최종 테스트 (1일)
1. ✅ 3개 이상 디바이스 테스트
2. ✅ 5명 이상 베타 테스터 피드백
3. ✅ 버그 수정 및 재테스트
4. ✅ Release APK 빌드
5. ✅ 최종 체크리스트 확인

---

## 🎯 가장 빠른 확인 방법

**Flutter 미설치 시:**
```bash
brew install flutter
cd caffeine_tracker
flutter pub get
flutter run
```
→ 5-10분이면 앱 확인 가능!

**Flutter 설치 완료 시:**
```bash
cd caffeine_tracker
flutter run
```
→ 1분이면 앱 실행!

---

## 📞 도움이 필요하면

- Flutter 공식 문서: https://docs.flutter.dev/
- Flutter 커뮤니티: https://flutter.dev/community
- 이슈 트래커: https://github.com/UjiinEatingTangerines/caffeine-tracker/issues
