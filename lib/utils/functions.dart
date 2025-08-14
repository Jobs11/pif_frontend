import 'package:flutter/material.dart';

Container searchbt(String title) {
  return Container(
    width: 105,
    height: 20,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.black),
    ),
    child: Text(title, style: TextStyle(fontSize: 15)),
  );
}

String hoursAgoFromMysql(String mysqlDate) {
  try {
    // MySQL 날짜 문자열 → DateTime 변환
    DateTime dateTime = DateTime.parse(mysqlDate);

    // 현재 시간
    DateTime now = DateTime.now();

    // 시간 차이 계산
    Duration diff = now.difference(dateTime);

    // 결과 반환
    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}분 전";
    } else {
      return "${diff.inHours}시간 전";
    }
  } catch (e) {
    // 파싱 실패 시
    return "날짜 형식 오류";
  }
}
