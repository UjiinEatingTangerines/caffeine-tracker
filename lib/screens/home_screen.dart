import 'package:flutter/material.dart';
import '../models/caffeine_calculator.dart';
import '../models/caffeine_entry.dart';
import '../widgets/ad_banner_widget.dart';
import '../services/ad_manager.dart';
import '../services/database_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CaffeineEntry> _entries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEntries();

    // 진입 시 전면 광고 표시 조건 체크
    AdManager.showInterstitialAdIfNeeded();
  }

  Future<void> _loadEntries() async {
    try {
      final entries = await DatabaseService.instance.readTodayEntries();
      setState(() {
        _entries = entries;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading entries: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final remaining = CaffeineCalculator.calculateTotalRemaining(_entries);
    final sleepTime = CaffeineCalculator.calculateSleepTime(_entries);

    return Scaffold(
      appBar: AppBar(
        title: const Text('☕ Caffeine Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // TODO: 기록 화면으로 이동
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // 상단: 현재 카페인 잔류량
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: remaining > 100
                          ? [Colors.orange, Colors.red]
                          : [Colors.blue, Colors.green],
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '체내 카페인',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${remaining.toStringAsFixed(1)} mg',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (sleepTime != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '잠들 수 있는 시간: ${_formatTime(sleepTime)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),

                // 중간: 오늘의 섭취 기록
                Expanded(
                  child: _entries.isEmpty
                      ? const Center(
                          child: Text(
                            '오늘 섭취한 카페인이 없습니다.\n아래 버튼을 눌러 추가해보세요!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _entries.length,
                          itemBuilder: (context, index) {
                            final entry = _entries[index];
                            final remaining = CaffeineCalculator
                                .calculateRemaining(
                                    entry.amount, entry.timestamp);
                            return Card(
                              child: ListTile(
                                title: Text(entry.drinkName),
                                subtitle: Text(
                                  '${entry.amount.toStringAsFixed(0)}mg - ${_formatDateTime(entry.timestamp)}',
                                ),
                                trailing: Text(
                                  '잔류: ${remaining.toStringAsFixed(1)}mg',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),

                // 하단: AdMob 배너
                const AdBannerWidget(),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // TODO: 음료 추가 화면으로 이동
          // await Navigator.pushNamed(context, '/add');
          // _loadEntries(); // 추가 후 새로고침

          // 임시: 테스트용 데이터 추가
          _showAddDrinkDialog();
        },
        icon: const Icon(Icons.add),
        label: const Text('카페인 추가'),
      ),
    );
  }

  // 임시: 테스트용 간단한 다이얼로그
  void _showAddDrinkDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('카페인 추가'),
        content: const Text('음료 추가 화면은 곧 구현됩니다.\n테스트용으로 아메리카노를 추가합니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              final entry = CaffeineEntry(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                drinkName: '아메리카노 (Tall)',
                amount: 150,
                timestamp: DateTime.now(),
              );
              await DatabaseService.instance.createEntry(entry);
              Navigator.pop(context);
              _loadEntries();
            },
            child: const Text('추가'),
          ),
        ],
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

  String _formatDateTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
