import 'package:flutter/material.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';
import 'package:pif_frontend/utils/month.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  late Map<String, List<Map<String, int>>> dates, subDates, addDates;
  late int todayYear = 0;
  late int todayMonth = 0;
  late int todayDay = 0;
  late int yesDay1 = 0, yesDay2 = 0, yesDay3 = 0;
  late int tomDay1 = 0, tomDay2 = 0, tomDay3 = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    dates = getDateRangeSeparated();
    todayYear = dates['today']![0]['year']!;
    todayMonth = dates['today']![0]['month']!;
    todayDay = dates['today']![0]['day']!;

    yesDay1 = dates['prev']![2]['day']!;
    yesDay2 = dates['prev']![1]['day']!;
    yesDay3 = dates['prev']![0]['day']!;

    tomDay1 = dates['next']![0]['day']!;
    tomDay2 = dates['next']![1]['day']!;
    tomDay3 = dates['next']![2]['day']!;
  }

  // 목록 데이터 바뀌는 거 수정해야함
  void prevMonth() {
    setState(() {
      subDates = getSubtractDatesWithToday(
        year: todayYear,
        month: todayMonth,
        day: todayDay,
      );
      todayYear = subDates['today']![0]['year']!;
      todayMonth = subDates['today']![0]['month']!;
      todayDay = subDates['today']![0]['day']!;

      yesDay1 = subDates['prev']![2]['day']!;
      yesDay2 = subDates['prev']![1]['day']!;
      yesDay3 = subDates['prev']![0]['day']!;

      tomDay1 = subDates['next']![0]['day']!;
      tomDay2 = subDates['next']![1]['day']!;
      tomDay3 = subDates['next']![2]['day']!;
    });
  }

  void nextMonth() {
    setState(() {
      addDates = getAddDatesWithToday(
        year: todayYear,
        month: todayMonth,
        day: todayDay,
      );
      todayYear = addDates['today']![0]['year']!;
      todayMonth = addDates['today']![0]['month']!;
      todayDay = addDates['today']![0]['day']!;

      yesDay1 = addDates['prev']![2]['day']!;
      yesDay2 = addDates['prev']![1]['day']!;
      yesDay3 = addDates['prev']![0]['day']!;

      tomDay1 = addDates['next']![0]['day']!;
      tomDay2 = addDates['next']![1]['day']!;
      tomDay3 = addDates['next']![2]['day']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43),
        child: PifAppbar(
          titlename: '기억의 서랍',
          isMenu: true,
          isBack: false,
          isColored: Color(0xFFA0E4E7),
          onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: PifSidbar(),
      body: Stack(
        children: [
          // 배경 이미지 (맨 아래)
          Positioned.fill(
            child: Image.asset(
              'assets/images/background/pif_main.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              padding: const EdgeInsets.fromLTRB(2, 16, 2, 12),
              decoration: BoxDecoration(
                color: Color(0x8CFFFFFF),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 750,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset(
                          'assets/images/addicon/left_arrow.png',
                          fit: BoxFit.cover,
                          width: 28,
                          height: 28,
                        ),
                        onPressed: prevMonth,
                      ),
                      SizedBox(width: 24),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFFFCFFD2),
                        ),
                        width: 35,
                        height: 35,
                        alignment: Alignment.center,
                        child: Text(
                          '$todayMonth월',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      SizedBox(width: 24),
                      IconButton(
                        icon: Image.asset(
                          'assets/images/addicon/right_arrow.png',
                          fit: BoxFit.cover,
                          width: 28,
                          height: 28,
                        ),
                        onPressed: nextMonth,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.fromLTRB(7.5, 0, 7.5, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black),
                      color: Color(0x80FFFFFF),
                    ),
                    width: double.infinity,
                    height: 37,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 3일 전
                        dayIcon("$yesDay1일", Color(0xFF3FD0C9), false),
                        // 2일 전
                        dayIcon("$yesDay2일", Color(0xFF7FE1DD), false),

                        // 1일 전
                        dayIcon("$yesDay3일", Color(0xFFBFF0EE), false),

                        // 당일
                        dayIcon("$todayDay일", Color(0xFFFFF8E7), true),

                        // 1일 후
                        dayIcon("$tomDay1일", Color(0xFFD6F4FB), false),

                        // 2일 후
                        dayIcon("$tomDay2일", Color(0xFFA6E3F7), false),

                        // 3일 후
                        dayIcon("$tomDay3일", Color(0xFF87CEEB), false),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.5),
                  Container(
                    decoration: BoxDecoration(color: Color(0xFF6AD9D4)),
                    width: double.infinity,
                    height: 6,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SizedBox(
                      height: 580,
                      child: ListView.separated(
                        // 불러온 데이터의 리스트 길이
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFCCFAF8),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.black),
                                ),
                                width: double.infinity,
                                height: 97,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    15,
                                    6,
                                    15,
                                    5,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // 작성 년도 월 일
                                          inputYT('20XX. XX. XX'),

                                          // 기록된 타이머
                                          inputYT('  00:00:00'),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          color: Color(0Xffffffff),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 54,
                                        child: Text(
                                          '  00:00:00',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container dayIcon(String day, Color dayColors, bool isDay) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: dayColors,
      ),
      width: 35,
      height: 30,
      child: Text(
        day,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
          decoration: isDay ? TextDecoration.underline : TextDecoration.none,
          decorationColor: Colors.blue, // 밑줄 색
          decorationThickness: 2,
        ),
      ),
    );
  }

  Container inputYT(String title) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0Xffffffff),
        border: Border.all(color: Colors.black),
      ),
      width: 140,
      height: 20,
      child: Text(title, style: TextStyle(fontSize: 15)),
    );
  }
}
