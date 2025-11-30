# 📱 iOS에서 Caffeine Tracker 테스트하기 (맥북 + 아이폰)

아이폰과 맥북만으로 앱을 테스트하는 완벽한 가이드입니다.

---

## 🚀 빠른 시작 (5분 안에 앱 실행)

### Step 1: Flutter 설치

```bash
# Homebrew로 Flutter 설치 (가장 쉬움)
brew install flutter

# 설치 확인
flutter doctor

# Xcode 명령줄 도구 설치
sudo xcode-select --install
```

### Step 2: iOS 시뮬레이터에서 실행

```bash
# 프로젝트로 이동
cd /Users/gimhyeon-u/caffein-app/caffeine_tracker

# 의존성 설치
flutter pub get

# iOS 시뮬레이터 실행
open -a Simulator

# 앱 실행
flutter run
```

**끝!** 🎉

시뮬레이터에서 앱이 실행됩니다.

---

## 📱 실제 아이폰에서 테스트하기

실제 아이폰에서 테스트하면 **AdMob 광고**까지 확인 가능합니다.

### 방법 1: 무료로 실제 아이폰에 설치 (권장)

Apple Developer 계정 없이도 7일간 유효한 앱 설치 가능!

#### Step 1: Xcode 설치

```bash
# Mac App Store에서 Xcode 검색 후 설치
# 또는 명령어로 확인
xcode-select -p

# Xcode가 없다면 App Store에서 설치 (무료, 용량 큼: ~15GB)
```

#### Step 2: Apple ID 등록 (Xcode에)

1. Xcode 실행
2. **Preferences (⌘,)** → **Accounts** 탭
3. **+ 버튼** → **Apple ID 추가**
4. 본인의 Apple ID로 로그인

#### Step 3: 아이폰을 맥북에 연결

1. USB 케이블로 아이폰 ↔ 맥북 연결
2. 아이폰에서 **"이 컴퓨터를 신뢰하시겠습니까?"** → **신뢰**
3. 맥북에서 아이폰 인식 확인:

```bash
flutter devices
```

**예상 출력:**
```
2 connected devices:

iPhone 15 Pro (mobile) • 00008120-XXXXXXXXXXXX • ios • iOS 17.1
iPhone 15 Pro Simulator (mobile) • XXXXXXXXXX • ios • com.apple.CoreSimulator.SimRuntime.iOS-17-0
```

#### Step 4: 앱 실행

```bash
cd /Users/gimhyeon-u/caffein-app/caffeine_tracker

# 연결된 아이폰에 설치 및 실행
flutter run
```

#### Step 5: 아이폰 설정 (최초 1회만)

앱이 빌드되면 아이폰 화면에 다음 에러가 나타날 수 있습니다:

> **"신뢰할 수 없는 개발자"**

**해결 방법:**
1. 아이폰 **설정** → **일반** → **VPN 및 기기 관리**
2. 본인의 Apple ID 선택
3. **"(Apple ID) 신뢰"** 탭
4. 앱 재실행

**완료!** 이제 실제 아이폰에서 앱이 실행됩니다.

---

### 방법 2: Apple Developer 계정으로 설치 ($99/년)

장기간 테스트나 TestFlight 배포를 원하면 Apple Developer 계정 필요.

#### 추가 비용
- **$99/년** (Apple Developer Program)

#### 장점
- ✅ 7일 제한 없음
- ✅ TestFlight로 베타 테스터 초대 가능
- ✅ App Store 배포 가능

#### 등록 방법
1. https://developer.apple.com/programs/ 접속
2. **Enroll** 클릭
3. $99 결제
4. 승인 대기 (1-2일)

---

## 🧪 테스트 시나리오

### 1️⃣ iOS 시뮬레이터 테스트 (맥북만)

**가능한 것:**
- ✅ 모든 UI 확인
- ✅ 카페인 계산 로직 확인
- ✅ SQLite 데이터 저장/불러오기
- ✅ 화면 전환 (Navigation)
- ✅ Hot reload로 빠른 개발

**불가능한 것:**
- ❌ **AdMob 광고 표시** (중요!)
- ❌ 실제 디바이스 성능 확인
- ❌ Touch ID / Face ID

**실행 방법:**
```bash
# 시뮬레이터 실행
open -a Simulator

# 앱 실행
flutter run
```

**디바이스 변경:**
```bash
# 사용 가능한 시뮬레이터 목록
flutter emulators

# 특정 시뮬레이터 실행
flutter emulators --launch apple_ios_simulator

# 다른 디바이스 테스트 (iPhone SE, iPhone 15 Pro 등)
# Simulator 앱에서: Device → iOS 17.x → iPhone 15 Pro
```

---

### 2️⃣ 실제 아이폰 테스트 (아이폰 + 맥북)

**가능한 것:**
- ✅ **모든 기능 (AdMob 광고 포함!)**
- ✅ 실제 성능 확인
- ✅ 터치 반응성
- ✅ 배터리 소모량
- ✅ Face ID 테스트

**실행 방법:**
```bash
# 아이폰을 USB로 연결

# 연결 확인
flutter devices

# 앱 실행
flutter run -d "iPhone 이름"
```

**AdMob 광고 확인:**
- 앱 실행 후 **1-2분 대기** (광고 로드 시간)
- 하단에 **배너 광고** 표시됨
- 3번째 세션에 **전면 광고** 표시됨

---

## 🔧 자주 발생하는 문제 해결

### 문제 1: "No provisioning profile found"

**에러 메시지:**
```
Error: No profiles for 'com.example.caffeineTracker' were found
```

**해결 방법:**

1. Xcode에서 프로젝트 열기:
```bash
open ios/Runner.xcworkspace
```

2. **Runner** 선택 → **Signing & Capabilities** 탭
3. **Team** 드롭다운에서 본인의 Apple ID 선택
4. **Bundle Identifier** 변경 (고유해야 함):
   - 예: `com.yourname.caffeinetracker`

5. 다시 실행:
```bash
flutter run
```

---

### 문제 2: "신뢰할 수 없는 개발자"

**아이폰 화면에 앱이 안 열림**

**해결 방법:**
1. 아이폰 **설정** 앱 열기
2. **일반** → **VPN 및 기기 관리**
3. 본인의 Apple ID 탭
4. **"(Apple ID) 신뢰"** 탭
5. 앱 재실행

---

### 문제 3: "Could not find an option named 'ios'"

**Flutter가 iOS를 지원하지 않는 경우**

**해결 방법:**
```bash
# Flutter 재설치
brew reinstall flutter

# Flutter 채널 확인 (stable 권장)
flutter channel stable
flutter upgrade

# iOS 도구 확인
flutter doctor

# Xcode 명령줄 도구 재설치
sudo xcode-select --reset
sudo xcode-select --install
```

---

### 문제 4: "CocoaPods not installed"

**에러 메시지:**
```
CocoaPods not installed or not in valid state.
```

**해결 방법:**
```bash
# CocoaPods 설치
sudo gem install cocoapods

# Pod 설치
cd ios
pod install
cd ..

# 앱 재실행
flutter run
```

---

### 문제 5: AdMob 광고가 안 나옴

**시뮬레이터에서:**
- ❌ AdMob 광고는 **시뮬레이터에서 절대 안 나옴**
- ✅ 실제 아이폰에서만 테스트 가능

**실제 아이폰에서도 안 나온다면:**

1. **Info.plist 확인:**
```bash
open ios/Runner/Info.plist
```

다음 내용 확인:
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-3940256099942544~1458002511</string>

<key>NSUserTrackingUsageDescription</key>
<string>This app uses your data to provide personalized ads.</string>
```

2. **1-2분 대기** (광고 로드 시간)

3. **인터넷 연결 확인**

4. **앱 재시작**

---

## 📋 iOS 테스트 체크리스트

### 시뮬레이터 테스트 (맥북만)
```
□ Flutter 설치 완료
□ 시뮬레이터 실행
□ 앱 시작 → 홈 화면 표시
□ 카페인 추가 다이얼로그 동작
□ 카페인 계산 정확도 확인
□ 데이터 저장/불러오기 확인
□ 다양한 디바이스 크기 테스트
  □ iPhone SE (작은 화면)
  □ iPhone 15 Pro (기본)
  □ iPhone 15 Pro Max (큰 화면)
□ Hot reload 테스트 (코드 수정 → 'r' 입력)
```

### 실제 아이폰 테스트
```
□ USB 연결 및 신뢰 설정
□ 앱 설치 및 실행
□ "신뢰할 수 없는 개발자" 해제
□ 모든 기능 동작 확인
□ **AdMob 광고 표시 확인** ⭐
  □ 배너 광고 (하단)
  □ 전면 광고 (3번째 세션)
□ 오프라인 모드 테스트
  □ 비행기 모드 활성화
  □ 모든 기능 동작 확인
□ 배터리 소모 확인
□ 앱 크래시 없는지 확인
□ Face ID 동작 확인 (해당되는 경우)
```

---

## 🚀 추천 워크플로우

### Phase 1: 시뮬레이터로 빠른 개발 (맥북)

```bash
# 시뮬레이터 실행
open -a Simulator

# 앱 실행 (Hot reload 활성화)
flutter run

# 코드 수정 후 터미널에서 'r' 입력 → 즉시 반영
```

**사용 시나리오:**
- UI 레이아웃 조정
- 기능 구현
- 버그 수정
- 빠른 반복 개발

---

### Phase 2: 실제 아이폰으로 최종 확인

```bash
# 아이폰 연결

# 아이폰에 설치
flutter run

# 광고, 성능, 사용성 확인
```

**사용 시나리오:**
- AdMob 광고 테스트
- 실제 사용 경험 확인
- 배포 전 최종 검증

---

## 🎯 맥북 + 아이폰 환경 최적 활용법

### 개발 중: 시뮬레이터 (90%)
- ✅ 빠른 빌드
- ✅ Hot reload
- ✅ 화면 크기 자유롭게 변경
- ✅ 맥북만으로 가능

### 최종 테스트: 실제 아이폰 (10%)
- ✅ AdMob 광고 확인 ⭐
- ✅ 실제 성능 확인
- ✅ 배포 전 최종 검증

---

## 📱 iOS 빌드 파일 생성 (.ipa)

나중에 다른 아이폰에 배포하려면:

### Debug 빌드 (테스트용)
```bash
flutter build ios --debug

# 빌드 파일 위치:
# build/ios/iphoneos/Runner.app
```

### Release 빌드 (배포용)
```bash
# 서명 필요 (Apple Developer 계정)
flutter build ios --release

# .ipa 생성
cd ios
xcodebuild -workspace Runner.xcworkspace \
  -scheme Runner \
  -configuration Release \
  -archivePath build/Runner.xcarchive \
  archive

xcodebuild -exportArchive \
  -archivePath build/Runner.xcarchive \
  -exportPath build \
  -exportOptionsPlist ExportOptions.plist
```

---

## 🎬 단계별 스크린샷 가이드

### 1. Xcode에서 Signing 설정

<img src="xcode-signing.png" width="600" />

1. Xcode 열기: `open ios/Runner.xcworkspace`
2. Runner 선택
3. Signing & Capabilities 탭
4. Team: 본인 Apple ID 선택
5. Bundle Identifier 변경

### 2. 아이폰 신뢰 설정

<img src="iphone-trust.png" width="300" />

설정 → 일반 → VPN 및 기기 관리 → Apple ID 신뢰

---

## 💡 Pro Tips

### Tip 1: 여러 시뮬레이터 동시 실행
```bash
# iPhone SE에서 실행
flutter run -d "iPhone SE"

# 다른 터미널에서 iPhone 15 Pro에서 실행
flutter run -d "iPhone 15 Pro"
```

### Tip 2: 시뮬레이터 위치 모의
Simulator → Features → Location → Custom Location
→ 카페 GPS 테스트 가능 (향후 기능)

### Tip 3: 시뮬레이터 스크린샷
```bash
# 시뮬레이터 화면 캡처
Command + S

# 저장 위치: ~/Desktop
```

### Tip 4: Flutter DevTools
```bash
flutter run

# 터미널에 나오는 URL 복사 (예: http://127.0.0.1:9100)
# 브라우저에서 열기 → 성능 분석, 위젯 트리 확인
```

---

## 📞 다음 단계

### 개발 완료 후
1. **TestFlight로 베타 테스트** (Apple Developer 필요)
2. **App Store 제출**

### TestFlight 베타 테스트
```bash
# 1. Archive 생성 (Xcode)
# 2. App Store Connect에 업로드
# 3. 테스터 초대 (최대 10,000명)
# 4. 링크 공유 → 즉시 다운로드 가능
```

---

## 🎯 지금 바로 시작하기

```bash
# 1. Flutter 설치
brew install flutter

# 2. 시뮬레이터 실행
open -a Simulator

# 3. 프로젝트로 이동
cd /Users/gimhyeon-u/caffein-app/caffeine_tracker

# 4. 의존성 설치
flutter pub get

# 5. 앱 실행
flutter run
```

**5분 후면 앱이 실행됩니다!** 🎉

---

## ❓ FAQ

**Q: 아이폰 없이 맥북만으로 개발 가능한가요?**
A: 네! 시뮬레이터로 90% 개발 가능합니다. 단, AdMob 광고는 실제 아이폰에서만 테스트 가능.

**Q: Apple Developer 계정이 꼭 필요한가요?**
A: 테스트만 한다면 불필요 ($0). App Store 배포하려면 필요 ($99/년).

**Q: 7일 제한이란?**
A: 무료 Apple ID로 설치한 앱은 7일 후 만료. 맥북에 다시 연결해서 재설치하면 됨.

**Q: Android 앱도 맥북에서 테스트 가능한가요?**
A: Android Studio + 에뮬레이터 설치하면 가능. 하지만 실제 안드로이드 폰이 없으면 AdMob 광고 테스트 불가.

**Q: 시뮬레이터가 느린데요?**
A: 맥북 사양에 따라 다름. M1/M2/M3 칩이면 매우 빠름. Intel 칩은 다소 느릴 수 있음.

---

**🚀 Happy Coding!**
