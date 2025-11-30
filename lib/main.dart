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

  runApp(const CaffeineTrackerApp());
}

class CaffeineTrackerApp extends StatelessWidget {
  const CaffeineTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caffeine Tracker',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
