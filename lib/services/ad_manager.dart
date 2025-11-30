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
