# 광고 수익 극대화 모바일 앱 개발 프로젝트
## Caffeine Half-Life Tracker MVP 전체 문서

---

## 📋 프로젝트 개요

**프로젝트명:** Caffeine Half-Life Tracker (카페인 반감기 트래커)
**목표:** AdMob 광고 수익을 극대화할 수 있는 고재방문율 모바일 앱
**기술 스택:** Flutter (Dart) + AdMob + SQLite
**개발 기간:** 2주 (MVP 기준)
**예상 월 수익:** DAU 1,000명 기준 $200~300

---

## 🎯 핵심 전략

### 1. Zero Cost Operation
- SQLite 로컬 DB 사용
- Firebase Free Tier 활용 (10GB/월)
- 외부 유료 API 사용 안 함
- 모든 계산은 디바이스 내부에서 처리

### 2. Copyright Free
- 약리학 공식 (공공 지식)
- Material Design 기본 위젯
- Flutter Icons (무료)
- 사용자 생성 데이터만 활용

### 3. Blue Ocean Strategy
- 카페인 반감기 특화 앱 거의 없음
- 기존 트래커는 단순 기록만 제공
- 실시간 체내 잔류량 시각화 차별화

### 4. 광고 노출 최적화
- 하루 평균 4~5회 세션
- 세션당 1.5분 체류
- 배너 광고 상시 노출
- 전면 광고 3세션당 1회

---

## 💡 아이디어 브레인스토밍 결과

### ✅ 선정된 아이디어: 카페인 반감기 트래커

**타겟 사용자:**
- 불면증 환자
- 카페인 민감자
- 수면 개선을 원하는 직장인/학생
- 커피 애호가

**핵심 기능:**
1. 커피/에너지드링크 섭취 시간과 양 입력
2. 실시간으로 체내 잔류 카페인 양 표시 (반감기 5.5시간 기준)
3. "잠들 수 있는 시간" 계산 및 알림
4. 오늘의 총 카페인 섭취량 그래프
5. 날짜별 섭취 기록 히스토리

**재방문율:** ★★★★★ (하루 4~5회)
- 아침 커피 (07:00)
- 점심 후 커피 (13:00)
- 오후 간식 (16:00)
- 저녁 체크 (20:00)
- 취침 전 확인 (23:00)

---

## 📊 시장 분석 및 경쟁력

### 경쟁 분석
- Play Store "caffeine tracker" 검색 결과: 일반 트래커만 존재
- "caffeine half-life" 특화 앱: **거의 없음**
- 기존 앱들의 문제점: 단순 기록만 제공, 실시간 시각화 부재

### 차별화 포인트
1. **실시간 체내 잔류량 시각화** (그래프)
2. **수면 가능 시간 자동 계산**
3. **심리적 트리거 활용** ("지금 커피 마시면 몇 시까지 못 자?")
4. **프리셋 음료 DB** (원터치 입력)

### 바이럴 가능성
- 불면증 커뮤니티 (Reddit r/insomnia, 디시인사이드)
- 수험생 커뮤니티 (오르비, 의대 갤러리)
- 직장인 커뮤니티 (블라인드)
- "오늘의 카페인 중독도" 공유 기능

---

## 💰 수익 모델 시뮬레이션

### 보수적 추정 (DAU 1,000명 기준)

```
일일 지표:
- DAU: 1,000명
- 1인당 세션: 4회/일
- 전면 광고 노출: 2회/일 (3세션당 1회)
- 배너 광고 상시 노출

광고 수익:
- 전면 광고 CPM: $3
- 배너 광고 CTR: 0.5%
- 일 수익: (1,000 × 2 × $3/1000) + 배너 = $6~10
- 월 수익: $200~300
```

### 성장 단계별 예측

| 단계 | 기간 | DAU | 월 수익 |
|------|------|-----|---------|
| Phase 1 | 출시 1개월 | 100명 | $20~30 |
| Phase 2 | 출시 3개월 | 1,000명 | $200~300 |
| Phase 3 | 출시 6개월 | 5,000명 | $1,000~1,500 |
| Phase 4 | 출시 1년 | 10,000+명 | $2,000~3,000 |

---

## 🛠️ 기술 스택

### Frontend
- **Framework:** Flutter 3.0+
- **언어:** Dart 3.0+
- **상태관리:** Provider

### Backend
- **로컬 DB:** SQLite (sqflite)
- **클라우드:** Firebase Free Tier (선택사항)

### 광고
- **플랫폼:** Google AdMob
- **패키지:** google_mobile_ads ^4.0.0

### UI/UX
- **차트:** fl_chart ^0.65.0
- **디자인:** Material Design 3
- **아이콘:** Flutter Icons (무료)

---

## 📁 프로젝트 구조

```
caffeine_tracker/
├── lib/
│   ├── main.dart                          # 앱 진입점 + AdMob 초기화
│   ├── models/
│   │   ├── caffeine_entry.dart            # 카페인 섭취 데이터 모델
│   │   └── caffeine_calculator.dart       # 반감기 계산 로직
│   ├── screens/
│   │   ├── home_screen.dart               # 메인 화면 (실시간 그래프)
│   │   ├── add_caffeine_screen.dart       # 음료 추가 화면
│   │   └── history_screen.dart            # 섭취 기록
│   ├── widgets/
│   │   ├── caffeine_realtime_chart.dart   # 실시간 잔류량 그래프
│   │   ├── drink_preset_card.dart         # 프리셋 음료 카드
│   │   └── ad_banner_widget.dart          # 배너 광고 위젯
│   ├── services/
│   │   ├── database_service.dart          # SQLite 로컬 DB
│   │   └── ad_manager.dart                # AdMob 광고 관리
│   └── constants/
│       └── drink_database.dart            # 음료별 카페인 함량
├── pubspec.yaml
├── android/
│   └── app/src/main/AndroidManifest.xml   # AdMob App ID 설정
└── ios/
    └── Runner/Info.plist                  # AdMob App ID 설정
```

---

## 📦 의존성 설정 (pubspec.yaml)

```yaml
name: caffeine_tracker
description: Track your caffeine intake and sleep better
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # 상태관리
  provider: ^6.1.1

  # 로컬 DB
  sqflite: ^2.3.0
  path: ^1.8.3

  # 광고 (AdMob)
  google_mobile_ads: ^4.0.0

  # 차트/그래프
  fl_chart: ^0.65.0

  # 날짜/시간 처리
  intl: ^0.18.1

  # UI
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

---

## 🧬 핵심 코드

### 1. 카페인 계산 로직 (models/caffeine_calculator.dart)

```dart
import 'dart:math';

class CaffeineCalculator {
  static const double halfLife = 5.5; // 카페인 반감기 (시간)
  static const double sleepThreshold = 25.0; // 수면 가능한 카페인 기준 (mg)

  /// 현재 시점의 잔류 카페인 계산
  static double calculateRemaining(double initialAmount, DateTime consumedAt) {
    final hoursElapsed = DateTime.now().difference(consumedAt).inMinutes / 60.0;
    return initialAmount * pow(0.5, hoursElapsed / halfLife);
  }

  /// 여러 섭취 기록의 총 잔류 카페인
  static double calculateTotalRemaining(List<CaffeineEntry> entries) {
    double total = 0;
    for (var entry in entries) {
      total += calculateRemaining(entry.amount, entry.timestamp);
    }
    return total;
  }

  /// 수면 가능한 시간 계산
  static DateTime? calculateSleepTime(List<CaffeineEntry> entries) {
    if (entries.isEmpty) return DateTime.now();

    // 가장 최근 섭취 시간부터 시작
    final latestEntry = entries.reduce((a, b) =>
      a.timestamp.isAfter(b.timestamp) ? a : b
    );

    // 이진 탐색으로 카페인이 25mg 이하로 떨어지는 시점 찾기
    DateTime searchTime = latestEntry.timestamp;
    for (int hours = 0; hours < 48; hours++) {
      searchTime = latestEntry.timestamp.add(Duration(hours: hours));
      double remaining = 0;

      for (var entry in entries) {
        final elapsed = searchTime.difference(entry.timestamp).inMinutes / 60.0;
        if (elapsed >= 0) {
          remaining += entry.amount * pow(0.5, elapsed / halfLife);
        }
      }

      if (remaining <= sleepThreshold) {
        return searchTime;
      }
    }

    return searchTime;
  }

  /// 시간별 카페인 곡선 데이터 생성 (그래프용)
  static List<ChartPoint> generateCurve(List<CaffeineEntry> entries,
                                        {int hoursAhead = 12}) {
    List<ChartPoint> points = [];
    final now = DateTime.now();

    for (int i = -6; i <= hoursAhead * 60; i += 30) { // 30분 간격
      final time = now.add(Duration(minutes: i));
      double total = 0;

      for (var entry in entries) {
        final elapsed = time.difference(entry.timestamp).inMinutes / 60.0;
        if (elapsed >= 0) {
          total += entry.amount * pow(0.5, elapsed / halfLife);
        }
      }

      points.add(ChartPoint(time, total));
    }

    return points;
  }
}

class ChartPoint {
  final DateTime time;
  final double value;
  ChartPoint(this.time, this.value);
}

class CaffeineEntry {
  final String id;
  final String drinkName;
  final double amount; // mg
  final DateTime timestamp;

  CaffeineEntry({
    required this.id,
    required this.drinkName,
    required this.amount,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'drinkName': drinkName,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory CaffeineEntry.fromMap(Map<String, dynamic> map) {
    return CaffeineEntry(
      id: map['id'],
      drinkName: map['drinkName'],
      amount: map['amount'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
```

---

### 2. 음료 데이터베이스 (constants/drink_database.dart)

```dart
class DrinkPreset {
  final String name;
  final double caffeineAmount; // mg
  final String emoji;

  const DrinkPreset(this.name, this.caffeineAmount, this.emoji);
}

class DrinkDatabase {
  static const List<DrinkPreset> presets = [
    DrinkPreset('에스프레소 샷', 63, '☕'),
    DrinkPreset('아메리카노 (Tall)', 150, '☕'),
    DrinkPreset('카페라떼 (Tall)', 75, '🥛'),
    DrinkPreset('콜드브루', 200, '🧊'),
    DrinkPreset('레드불 (250ml)', 80, '🔋'),
    DrinkPreset('핫식스 (250ml)', 60, '⚡'),
    DrinkPreset('몬스터 에너지', 160, '👹'),
    DrinkPreset('코카콜라 (355ml)', 34, '🥤'),
    DrinkPreset('녹차', 25, '🍵'),
    DrinkPreset('홍차', 47, '🫖'),
  ];
}
```

---

### 3. AdMob 광고 관리자 (services/ad_manager.dart)

```dart
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class AdManager {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; // 테스트 ID
      // 실제 배포 시: 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // 테스트 ID
    }
    throw UnsupportedError('Unsupported platform');
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712'; // 테스트 ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910'; // 테스트 ID
    }
    throw UnsupportedError('Unsupported platform');
  }

  // 전면 광고 로드
  static Future<InterstitialAd?> loadInterstitialAd() async {
    InterstitialAd? interstitialAd;

    await InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );

    return interstitialAd;
  }

  // 전면 광고 표시 (세션 카운트 기반)
  static int _sessionCount = 0;
  static InterstitialAd? _cachedInterstitialAd;

  static Future<void> showInterstitialAdIfNeeded() async {
    _sessionCount++;

    // 3번째 세션마다 광고 표시
    if (_sessionCount % 3 == 0) {
      if (_cachedInterstitialAd != null) {
        await _cachedInterstitialAd!.show();
        _cachedInterstitialAd = null;

        // 다음 광고 미리 로드
        _cachedInterstitialAd = await loadInterstitialAd();
      }
    }
  }

  static Future<void> preloadInterstitialAd() async {
    _cachedInterstitialAd = await loadInterstitialAd();
  }
}
```

---

### 4. 메인 화면 (screens/home_screen.dart)

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/caffeine_calculator.dart';
import '../widgets/caffeine_realtime_chart.dart';
import '../widgets/ad_banner_widget.dart';
import '../services/ad_manager.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CaffeineEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();

    // 진입 시 전면 광고 표시 조건 체크
    AdManager.showInterstitialAdIfNeeded();
  }

  Future<void> _loadEntries() async {
    // TODO: DatabaseService에서 오늘의 기록 로드
    setState(() {
      // 샘플 데이터
      _entries = [
        CaffeineEntry(
          id: '1',
          drinkName: '아메리카노',
          amount: 150,
          timestamp: DateTime.now().subtract(Duration(hours: 3)),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final remaining = CaffeineCalculator.calculateTotalRemaining(_entries);
    final sleepTime = CaffeineCalculator.calculateSleepTime(_entries);

    return Scaffold(
      appBar: AppBar(
        title: Text('☕ Caffeine Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // TODO: 기록 화면으로 이동
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 상단: 현재 카페인 잔류량
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: remaining > 100
                  ? [Colors.orange, Colors.red]
                  : [Colors.blue, Colors.green],
              ),
            ),
            child: Column(
              children: [
                Text(
                  '체내 카페인',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  '${remaining.toStringAsFixed(1)} mg',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                if (sleepTime != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '잠들 수 있는 시간: ${_formatTime(sleepTime)}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),

          // 중간: 그래프
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CaffeineRealtimeChart(entries: _entries),
            ),
          ),

          // 하단: AdMob 배너
          AdBannerWidget(),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // TODO: 음료 추가 화면으로 이동
          await Navigator.pushNamed(context, '/add');
          _loadEntries(); // 추가 후 새로고침
        },
        icon: Icon(Icons.add),
        label: Text('카페인 추가'),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = time.difference(now);

    if (diff.isNegative) return '지금 가능';
    if (diff.inHours > 0) {
      return '${diff.inHours}시간 ${diff.inMinutes % 60}분 후';
    }
    return '${diff.inMinutes}분 후';
  }
}
```

---

### 5. 배너 광고 위젯 (widgets/ad_banner_widget.dart)

```dart
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ad_manager.dart';

class AdBannerWidget extends StatefulWidget {
  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    _bannerAd!.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) {
      return SizedBox(height: 50); // 광고 로딩 중 공간 유지
    }

    return Container(
      alignment: Alignment.center,
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
```

---

### 6. 앱 진입점 (main.dart)

```dart
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'screens/home_screen.dart';
import 'services/ad_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // AdMob 초기화
  await MobileAds.instance.initialize();

  // 전면 광고 미리 로드
  await AdManager.preloadInterstitialAd();

  runApp(CaffeineTrackerApp());
}

class CaffeineTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caffeine Tracker',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```

---

## 🚀 MVP 개발 로드맵 (2주 계획)

### Week 1: 핵심 기능 개발

#### Day 1-2: 프로젝트 초기 설정
- [ ] Flutter 프로젝트 생성
- [ ] 의존성 패키지 설치
- [ ] 데이터 모델 구현 (CaffeineEntry)
- [ ] 카페인 계산 로직 구현

#### Day 3-4: UI 구현
- [ ] 메인 화면 레이아웃
- [ ] 실시간 그래프 위젯 (fl_chart)
- [ ] 카페인 잔류량 표시
- [ ] 수면 가능 시간 표시

#### Day 5-6: 데이터 영속성
- [ ] SQLite DB 구조 설계
- [ ] DatabaseService 구현
- [ ] CRUD 기능 완성
- [ ] 샘플 데이터 테스트

#### Day 7: AdMob 통합
- [ ] AdMob 계정 생성 및 앱 등록
- [ ] 배너 광고 위젯 구현
- [ ] 전면 광고 로직 구현
- [ ] 광고 테스트

---

### Week 2: 완성도 향상

#### Day 8-9: 음료 추가 기능
- [ ] 음료 추가 화면 UI
- [ ] 프리셋 음료 카드 위젯
- [ ] 커스텀 음료 입력 기능
- [ ] DB 저장 연동

#### Day 10-11: 추가 기능
- [ ] 섭취 기록 히스토리 화면
- [ ] 날짜별 필터링
- [ ] 기록 삭제 기능
- [ ] 다크모드 지원 (선택사항)

#### Day 12-13: 버그 수정 및 폴리싱
- [ ] 전체 기능 테스트
- [ ] UI/UX 개선
- [ ] 성능 최적화
- [ ] 에러 핸들링

#### Day 14: 배포 준비
- [ ] 앱 아이콘 제작
- [ ] 스크린샷 촬영 (5장)
- [ ] Play Store 설명 작성
- [ ] 개인정보처리방침 작성
- [ ] APK/AAB 빌드

---

## 📱 개발 시작하기

### 1단계: 프로젝트 생성

```bash
# Flutter 설치 확인
flutter doctor

# 프로젝트 생성
flutter create caffeine_tracker
cd caffeine_tracker

# pubspec.yaml 수정 (위의 의존성 설정 참고)

# 패키지 설치
flutter pub get
```

---

### 2단계: AdMob 설정

#### Android 설정
**파일:** `android/app/src/main/AndroidManifest.xml`

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="caffeine_tracker"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">

        <!-- AdMob App ID -->
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-XXXXXXXXXXXXXXXX~YYYYYYYYYY"/>

        <activity
            android:name=".MainActivity"
            ...
        </activity>
    </application>
</manifest>
```

#### iOS 설정
**파일:** `ios/Runner/Info.plist`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- 기존 설정들 -->

    <!-- AdMob App ID -->
    <key>GADApplicationIdentifier</key>
    <string>ca-app-pub-XXXXXXXXXXXXXXXX~YYYYYYYYYY</string>

    <!-- App Tracking Transparency (iOS 14+) -->
    <key>NSUserTrackingUsageDescription</key>
    <string>This app uses your data to provide personalized ads.</string>
</dict>
</plist>
```

---

### 3단계: 실행 및 테스트

```bash
# Android 에뮬레이터 실행
flutter run

# iOS 시뮬레이터 실행 (Mac만 가능)
flutter run -d ios

# 빌드
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

---

## 📈 광고 최적화 전략

### 광고 배치 시나리오

```
1. 앱 시작
   └─> 3번째 오픈부터 전면 광고 (이탈 방지)

2. 홈 화면
   └─> 하단 배너 광고 상시 노출

3. 음료 추가 완료
   └─> 50% 확률로 전면 광고

4. 기록 조회
   └─> 배너 광고

5. 리워드 광고 (선택사항)
   └─> "수면 개선 팁 보기" 기능
```

### 광고 빈도 조절 전략

```dart
// services/ad_manager.dart 수정 예시

class AdManager {
  static int _sessionCount = 0;
  static DateTime? _lastInterstitialTime;

  static Future<void> showInterstitialAdIfNeeded() async {
    _sessionCount++;

    // 조건 1: 3번째 세션마다
    // 조건 2: 마지막 광고로부터 5분 경과
    final shouldShow = _sessionCount % 3 == 0 &&
        (_lastInterstitialTime == null ||
         DateTime.now().difference(_lastInterstitialTime!).inMinutes >= 5);

    if (shouldShow && _cachedInterstitialAd != null) {
      await _cachedInterstitialAd!.show();
      _lastInterstitialTime = DateTime.now();
      _cachedInterstitialAd = null;
      _cachedInterstitialAd = await loadInterstitialAd();
    }
  }
}
```

---

## 🎯 바이럴 마케팅 전략

### 1. 커뮤니티 타겟팅

**Reddit (영어권)**
- r/insomnia (불면증)
- r/decaf (카페인 중독 탈출)
- r/sleep (수면 개선)
- r/productivity (생산성)

**한국 커뮤니티**
- 디시인사이드 불면증갤러리
- 오르비 (수험생)
- 블라인드 (직장인)
- 의대 갤러리 (의대생/수험생)

---

### 2. 공유 기능 추가 (v2.0 계획)

```dart
// "오늘의 카페인 중독도" 이미지 생성 및 공유

void shareMyStats() {
  // 1. 오늘의 총 섭취량 계산
  // 2. 예쁜 그래프 이미지 생성
  // 3. "나는 오늘 커피 5잔 (750mg) 마셨어요 ☕" 텍스트와 함께 공유
  // 4. 앱 다운로드 링크 자동 포함
}
```

---

### 3. App Store Optimization (ASO)

**키워드 전략**
- 주요 키워드: 카페인, 불면증, 수면, 커피, 트래커
- 영어: caffeine, sleep, insomnia, coffee tracker
- 검색량: "caffeine tracker" (월 5,000+), "sleep better" (월 50,000+)

**스크린샷 전략**
1. 메인 화면 (실시간 잔류량)
2. 그래프 화면 (시각화 강조)
3. 음료 추가 화면 (사용 편의성)
4. "잠들 수 있는 시간" 알림
5. 히스토리 화면

**앱 설명 (첫 3줄이 중요)**
```
☕ 오늘 마신 커피, 언제까지 영향을 줄까요?
실시간으로 체내 카페인 잔류량을 계산하고,
언제 잠들 수 있는지 알려드립니다.
```

---

## ⚠️ 법적 주의사항

### 1. 의료 기기 면책
앱 설명 및 앱 내에 다음 문구 필수 삽입:

```
⚠️ 면책 조항
이 앱은 참고용 정보만 제공하며, 의학적 조언이나 진단 도구가 아닙니다.
수면 장애가 있다면 전문의와 상담하세요.
```

---

### 2. 개인정보처리방침
- 이메일, 이름 등 개인정보 수집 금지 (GDPR/CCPA 회피)
- AdMob 광고 ID만 수집 (자동)
- 간단한 개인정보처리방침 페이지 생성

**샘플 정책:**
```
개인정보처리방침

1. 수집 정보
   - 광고 식별자 (AdMob)
   - 앱 사용 통계 (Firebase Analytics, 선택사항)

2. 사용 목적
   - 광고 제공
   - 앱 개선

3. 제3자 제공
   - Google AdMob만 제공

4. 데이터 보관
   - 로컬 디바이스에만 저장
```

---

### 3. Play Store / App Store 정책 준수
- **광고 과다 금지:** 전면 광고는 3~5세션당 1회 이하
- **오도하는 설명 금지:** "불면증 치료" 같은 표현 사용 금지
- **아이콘/스크린샷 품질:** 고해상도 이미지 필수

---

## 🔧 추가 개발 아이디어 (v2.0+)

### 1. 프리미엄 기능 (인앱 결제)
- 광고 제거 ($2.99)
- 무제한 히스토리 보관
- 커스텀 반감기 설정 (개인 체질 반영)
- 위젯 지원 (홈 화면에 잔류량 표시)

---

### 2. 소셜 기능
- "오늘의 카페인 랭킹" (익명)
- "이번 주 최고 카페인 중독자" 뱃지
- 친구와 비교 (선택사항)

---

### 3. 건강 앱 연동
- Apple Health / Google Fit 연동
- 수면 데이터와 카페인 섭취 상관관계 분석
- "수면 시간이 짧았던 날은 카페인 섭취가 많았어요" 인사이트

---

### 4. AI 추천 (로컬 모델 사용)
- TensorFlow Lite로 경량 모델 탑재
- "지금 커피 마시면 수면에 영향을 줄 확률: 87%"
- 개인 패턴 학습 (디바이스 내부에서만)

---

## 📊 성공 지표 (KPI)

### 앱 출시 후 모니터링 지표

| 지표 | 목표 (3개월) | 측정 방법 |
|------|-------------|----------|
| DAU | 1,000명 | Firebase Analytics |
| 평균 세션 시간 | 1.5분 | Firebase Analytics |
| 일일 세션 수 | 4회/사용자 | Firebase Analytics |
| 리텐션 (7일) | 30% | Firebase Analytics |
| 광고 CTR | 0.5% | AdMob 대시보드 |
| 평균 일일 수익 | $6~10 | AdMob 대시보드 |
| 앱스토어 평점 | 4.3+ | 사용자 리뷰 |

---

## 🎉 최종 체크리스트

### 개발 완료 전 필수 확인 사항

- [ ] 모든 화면에서 광고가 정상 표시되는가?
- [ ] 앱이 오프라인에서도 작동하는가?
- [ ] 광고 ID가 테스트 ID에서 실제 ID로 변경되었는가?
- [ ] 개인정보처리방침 페이지가 작성되었는가?
- [ ] 앱 아이콘이 고해상도인가? (1024x1024)
- [ ] 스크린샷이 5장 준비되었는가?
- [ ] 면책 조항이 앱 내에 표시되는가?
- [ ] Android/iOS 모두 빌드 성공했는가?
- [ ] 앱 크기가 50MB 이하인가?
- [ ] 테스트 사용자 5명 이상 피드백 받았는가?

---

## 💬 FAQ

**Q: Flutter 경험이 없는데 가능한가요?**
A: 2주는 Flutter 학습 시간을 포함하지 않습니다. Flutter 기초가 있다면 가능합니다.

**Q: AdMob 수익이 정말 나오나요?**
A: DAU가 100명 이하면 월 $10~30 정도로 미미합니다. 1,000명 이상부터 의미 있는 수익이 발생합니다.

**Q: iOS도 배포해야 하나요?**
A: Android 먼저 배포하고, 반응이 좋으면 iOS 추가 권장 (iOS 개발자 계정 $99/년).

**Q: 카페인 반감기 5.5시간이 정확한가요?**
A: 평균값입니다. 개인차가 있으므로 앱에 면책 조항을 명시해야 합니다.

**Q: 광고가 너무 많으면 사용자가 떠나지 않나요?**
A: 전면 광고는 3~5세션당 1회로 제한하고, 배너 광고만 상시 노출하세요.

---

## 📚 참고 자료

### Flutter 학습
- [Flutter 공식 문서](https://docs.flutter.dev/)
- [Flutter Codelabs](https://docs.flutter.dev/codelabs)

### AdMob 통합
- [google_mobile_ads 패키지](https://pub.dev/packages/google_mobile_ads)
- [AdMob 공식 가이드](https://developers.google.com/admob/flutter/quick-start)

### 차트/그래프
- [fl_chart 예제](https://github.com/imaNNeo/fl_chart/tree/main/example)

### App Store 등록
- [Play Console 가이드](https://support.google.com/googleplay/android-developer)
- [App Store Connect 가이드](https://developer.apple.com/app-store/submissions/)

---

## 📞 프로젝트 진행 상황

### ✅ 완료된 작업 (2025-11-30)

1. ✅ Flutter 프로젝트 생성 (caffeine_tracker/)
2. ✅ 핵심 모델 파일 구현
   - lib/models/caffeine_entry.dart
   - lib/models/caffeine_calculator.dart
3. ✅ 상수 파일 구현
   - lib/constants/drink_database.dart (10개 프리셋)
4. ✅ 서비스 파일 구현
   - lib/services/database_service.dart (SQLite)
   - lib/services/ad_manager.dart (AdMob 테스트 ID)
5. ✅ 위젯 파일 구현
   - lib/widgets/ad_banner_widget.dart
6. ✅ 기본 화면 구현
   - lib/screens/home_screen.dart (현재 카페인 표시)
   - lib/main.dart (AdMob 초기화)
7. ✅ GitHub 저장소 생성
   - https://github.com/UjiinEatingTangerines/caffeine-tracker

---

## 🚧 다음 작업 (Next Steps)

### Week 2: MVP 완성

#### Day 8-9: 음료 추가 기능 ⬅️ **현재 작업**
- [ ] **lib/widgets/drink_preset_card.dart** 생성
  - DrinkPreset을 카드 형태로 표시
  - 이모지, 음료명, 카페인 함량 표시
  - onTap 콜백으로 선택 처리
  - Material Design 3 스타일 (elevation 2, borderRadius 12)

- [ ] **lib/screens/add_caffeine_screen.dart** 생성
  - 상단: 프리셋 음료 그리드 (2열, GridView)
  - 중간: 커스텀 입력 폼 (음료명, 카페인 양)
  - 하단: DateTimePicker (섭취 시간 선택)
  - "추가하기" 버튼 → DatabaseService.instance.createEntry()
  - 입력 검증 (카페인 양 > 0, 음료명 필수)
  - 저장 후 Navigator.pop()으로 홈 화면 복귀

- [ ] **lib/screens/home_screen.dart** 업데이트
  - FloatingActionButton의 임시 다이얼로그 제거
  - Navigator.push로 add_caffeine_screen 연결
  - 추가 완료 후 _loadEntries() 자동 호출

**완료 조건**:
- 프리셋 음료 탭으로 빠른 추가 가능
- 커스텀 음료 입력 가능
- 추가한 음료가 홈 화면에 즉시 표시됨

---

#### Day 10-11: 히스토리 및 차트
- [ ] **lib/screens/history_screen.dart** 생성
  - DatabaseService.readAllEntries() 사용
  - 날짜별로 그룹핑된 ListView
  - Dismissible로 swipe to delete 구현
  - 날짜별 총 카페인 합계 표시
  - 하단에 AdBannerWidget 배치

- [ ] **lib/widgets/caffeine_realtime_chart.dart** 생성
  - fl_chart의 LineChart 위젯 사용
  - CaffeineCalculator.generateCurve() 데이터 표시
  - X축: 시간 (과거 6시간 ~ 미래 12시간)
  - Y축: 카페인 (mg)
  - 수면 임계값 25mg 수평선 표시
  - 그라데이션 배경 (높을수록 빨강)

- [ ] **lib/screens/home_screen.dart** 업데이트
  - 중간 섹션에 caffeine_realtime_chart 추가
  - AppBar의 history 버튼 → history_screen 연결

**완료 조건**:
- 과거 기록 조회 및 삭제 가능
- 실시간 카페인 감소 곡선 시각화
- 수면 가능 시간이 그래프에서 명확히 보임

---

#### Day 12: AdMob 설정 완성
- [ ] **android/app/src/main/AndroidManifest.xml** 생성/수정
  ```xml
  <meta-data
      android:name="com.google.android.gms.ads.APPLICATION_ID"
      android:value="ca-app-pub-3940256099942544~3347511713"/>
  ```

- [ ] **ios/Runner/Info.plist** 생성/수정
  ```xml
  <key>GADApplicationIdentifier</key>
  <string>ca-app-pub-3940256099942544~1458002511</string>
  <key>NSUserTrackingUsageDescription</key>
  <string>This app uses your data to provide personalized ads.</string>
  ```

**완료 조건**:
- Android/iOS에서 AdMob 테스트 광고 정상 표시
- 배너 광고가 모든 화면 하단에 표시됨
- 전면 광고가 3번째 세션마다 표시됨

---

#### Day 13: 테스트 및 버그 수정
- [ ] 전체 기능 테스트
  - 카페인 추가 → 홈 화면 업데이트 확인
  - 시간 경과에 따른 카페인 감소 확인
  - 수면 시간 계산 정확도 확인
  - 데이터베이스 persistence 테스트 (앱 재시작)
  - 광고 표시 테스트 (실제 디바이스)

- [ ] 오프라인 모드 테스트
  - 비행기 모드에서 모든 기능 동작 확인
  - 광고는 로드 실패해도 앱 정상 작동

- [ ] UI/UX 개선
  - 로딩 상태 표시
  - 에러 메시지 SnackBar
  - 빈 상태 메시지 (Empty state)

**완료 조건**:
- 모든 핵심 기능이 오류 없이 동작
- 오프라인에서도 사용 가능
- 사용자 친화적인 에러 처리

---

#### Day 14: 배포 준비
- [ ] **면책 조항 추가**
  - Settings 화면 또는 About 다이얼로그 생성
  - "⚠️ 이 앱은 참고용 정보만 제공하며, 의학적 조언이나 진단 도구가 아닙니다." 표시

- [ ] **개인정보처리방침 페이지**
  - 간단한 텍스트 화면 생성
  - 수집 정보: 광고 ID만
  - 데이터 저장: 로컬 디바이스만

- [ ] **앱 아이콘 제작**
  - 1024x1024 해상도
  - 커피 + 시계 조합 디자인
  - flutter_launcher_icons 패키지 사용

- [ ] **스크린샷 촬영** (Play Store용)
  1. 홈 화면 (현재 카페인 레벨 표시)
  2. 그래프 화면 (감소 곡선)
  3. 음료 추가 화면 (프리셋 그리드)
  4. 수면 시간 계산 결과
  5. 히스토리 화면

- [ ] **빌드 및 검증**
  ```bash
  # 버전 확인 (pubspec.yaml에서 1.0.0+1)
  # 모든 TODO 주석 제거
  # AdMob 테스트 ID 확인 (프로덕션 아직 아님)
  flutter build apk --release
  flutter build appbundle --release
  ```

**완료 조건**:
- 법적 요구사항 충족 (면책, 개인정보처리방침)
- Play Store 제출 준비 완료
- APK/AAB 파일 생성 성공
- 앱 크기 < 50MB

---

## 🚀 MVP 완성 후 다음 단계

### v1.1 업데이트 (출시 후 1개월)
- [ ] 사용자 피드백 반영
- [ ] 크래시 로그 분석 및 수정
- [ ] AdMob 실제 수익 데이터 분석
- [ ] 프로덕션 AdMob ID로 교체

### v2.0 기능 추가 (출시 후 3개월)
- [ ] 위젯 지원 (홈 화면에 현재 카페인 표시)
- [ ] 푸시 알림 ("커피 마실 시간이에요!")
- [ ] 다크 모드
- [ ] 다국어 지원 (영어, 한국어)
- [ ] 프리미엄 기능 (광고 제거 $2.99)

---

## 📋 즉시 사용 가능한 프롬프트

```
@CLAUDE.md @caffeine_tracker_mvp_plan.md @lib/constants/drink_database.dart

Week 2 Day 8-9 작업 시작:
음료 추가 기능을 구현해줘.

다음 파일들을 순서대로 생성:
1. lib/widgets/drink_preset_card.dart
2. lib/screens/add_caffeine_screen.dart
3. lib/screens/home_screen.dart 업데이트

MVP 계획서의 "다음 작업" 섹션을 참고하고,
완료되면 체크리스트를 업데이트해줘.
```

---

**🚀 현재 진행률: 60% (Week 1 완료, Week 2 진행 중)**

---

**문서 버전:** 1.1
**최종 업데이트:** 2025-11-30
**GitHub:** https://github.com/UjiinEatingTangerines/caffeine-tracker
**라이선스:** MIT (코드), CC BY 4.0 (문서)
