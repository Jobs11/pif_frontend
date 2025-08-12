Map<String, List<Map<String, int>>> getDateRangeSeparated() {
  DateTime today = DateTime.now();

  // 월, 일, 연도를 모두 반환
  Map<String, int> getMonthDay(DateTime date) {
    return {"year": date.year, "month": date.month, "day": date.day};
  }

  Map<String, int> todayMap = getMonthDay(today);

  List<Map<String, int>> prevDays = List.generate(3, (i) {
    return getMonthDay(today.subtract(Duration(days: i + 1)));
  });

  List<Map<String, int>> nextDays = List.generate(3, (i) {
    return getMonthDay(today.add(Duration(days: i + 1)));
  });

  return {
    "today": [todayMap],
    "prev": prevDays,
    "next": nextDays,
  };
}

Map<String, List<Map<String, int>>> getSubtractDatesWithToday({
  required int year,
  required int month,
  required int day,
}) {
  // 1) 입력 날짜에서 하루 빼기
  final DateTime base = DateTime(
    year,
    month,
    day,
  ).subtract(const Duration(days: 1));

  Map<String, int> ymd(DateTime d) => {
    "year": d.year,
    "month": d.month,
    "day": d.day,
  };

  // 2) (하루 뺀) 기준 날짜 = today
  final Map<String, int> today = ymd(base);

  // 3) 1~3일 전/후 계산
  final List<Map<String, int>> prev = List.generate(
    3,
    (i) => ymd(base.subtract(Duration(days: i + 1))),
  );
  final List<Map<String, int>> next = List.generate(
    3,
    (i) => ymd(base.add(Duration(days: i + 1))),
  );

  return {
    "today": [today],
    "prev": prev, // 1일 전, 2일 전, 3일 전 (이 순서)
    "next": next, // 1일 후, 2일 후, 3일 후 (이 순서)
  };
}

Map<String, List<Map<String, int>>> getAddDatesWithToday({
  required int year,
  required int month,
  required int day,
}) {
  // 1) 입력 날짜에서 하루 빼기
  final DateTime base = DateTime(year, month, day).add(const Duration(days: 1));

  Map<String, int> ymd(DateTime d) => {
    "year": d.year,
    "month": d.month,
    "day": d.day,
  };

  // 2) (하루 뺀) 기준 날짜 = today
  final Map<String, int> today = ymd(base);

  // 3) 1~3일 전/후 계산
  final List<Map<String, int>> prev = List.generate(
    3,
    (i) => ymd(base.subtract(Duration(days: i + 1))),
  );
  final List<Map<String, int>> next = List.generate(
    3,
    (i) => ymd(base.add(Duration(days: i + 1))),
  );

  return {
    "today": [today],
    "prev": prev, // 1일 전, 2일 전, 3일 전 (이 순서)
    "next": next, // 1일 후, 2일 후, 3일 후 (이 순서)
  };
}
