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
