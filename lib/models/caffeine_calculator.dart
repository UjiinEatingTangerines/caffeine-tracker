import 'dart:math';
import 'caffeine_entry.dart';

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
