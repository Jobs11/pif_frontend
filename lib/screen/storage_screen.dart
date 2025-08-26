import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';
import 'package:pif_frontend/model/currentuser.dart';
import 'package:pif_frontend/model/record.dart';
import 'package:pif_frontend/service/recordservice.dart';
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
  late String date;

  late Future<List<Records>> records;

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

    (todayMonth < 10)
        ? (todayDay < 10)
              ? date = '$todayYear년 0$todayMonth월 0$todayDay'
              : date = '$todayYear년 0$todayMonth월 $todayDay'
        : (todayDay < 10)
        ? date = '$todayYear년 $todayMonth월 0$todayDay'
        : date = '$todayYear년 $todayMonth월 $todayDay';

    records = Recordservice.getRecordList(
      CurrentUser.instance.member!.mId,
      date,
    );
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

      (todayMonth < 10)
          ? (todayDay < 10)
                ? date = '$todayYear년 0$todayMonth월 0$todayDay'
                : date = '$todayYear년 0$todayMonth월 $todayDay'
          : (todayDay < 10)
          ? date = '$todayYear년 $todayMonth월 0$todayDay'
          : date = '$todayYear년 $todayMonth월 $todayDay';

      records = Recordservice.getRecordList(
        CurrentUser.instance.member!.mId,
        date,
      );
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

      (todayMonth < 10)
          ? (todayDay < 10)
                ? date = '$todayYear년 0$todayMonth월 0$todayDay'
                : date = '$todayYear년 0$todayMonth월 $todayDay'
          : (todayDay < 10)
          ? date = '$todayYear년 $todayMonth월 0$todayDay'
          : date = '$todayYear년 $todayMonth월 $todayDay';

      records = Recordservice.getRecordList(
        CurrentUser.instance.member!.mId,
        date,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43.h),
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
              margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0.h),
              padding: EdgeInsets.fromLTRB(2.w, 16.h, 2.w, 12.h),
              decoration: BoxDecoration(
                color: Color(0x8CFFFFFF),
                borderRadius: BorderRadius.circular(12.r),
              ),
              height: 750.h,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset(
                          'assets/images/addicon/left_arrow.png',
                          fit: BoxFit.cover,
                          width: 28.w,
                          height: 28.h,
                        ),
                        onPressed: prevMonth,
                      ),
                      SizedBox(width: 24.w),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFFFCFFD2),
                        ),
                        width: 35.w,
                        height: 35.h,
                        alignment: Alignment.center,
                        child: Text(
                          '$todayMonth월',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                      SizedBox(width: 24.w),
                      IconButton(
                        icon: Image.asset(
                          'assets/images/addicon/right_arrow.png',
                          fit: BoxFit.cover,
                          width: 28.w,
                          height: 28.h,
                        ),
                        onPressed: nextMonth,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.fromLTRB(7.5.w, 0.h, 7.5.w, 0.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: Colors.black),
                      color: Color(0x80FFFFFF),
                    ),
                    width: double.infinity,
                    height: 37.h,
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
                  SizedBox(height: 8.5.h),
                  Container(
                    decoration: BoxDecoration(color: Color(0xFF6AD9D4)),
                    width: double.infinity,
                    height: 6.h,
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.w, 0.h, 15.w, 0.h),
                    child: SizedBox(
                      height: 580.h,
                      child: FutureBuilder<List<Records>>(
                        future: records, // ← 서버 호출 Future
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('불러오기 실패: ${snapshot.error}'),
                            );
                          }

                          final items = snapshot.data ?? const <Records>[];
                          if (items.isEmpty) {
                            return const Center(child: Text('기록이 없습니다.'));
                          }

                          return ListView.separated(
                            itemCount: items.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 13.h),
                            itemBuilder: (context, index) {
                              final r = items[index];

                              // 모델 필드명에 맞게 수정하세요.
                              // 예시: r.rDate, r.rTime, r.rDecoration
                              final displayDate = r.rDate;
                              final displayTimer = r.rTime;
                              final memo = (r.rDecoration.isEmpty)
                                  ? '(메모 없음)'
                                  : r.rDecoration;

                              return Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFCCFAF8),
                                  borderRadius: BorderRadius.circular(30.r),
                                  border: Border.all(color: Colors.black),
                                ),
                                width: double.infinity,
                                height: 117.h,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    15.w,
                                    6.h,
                                    15.w,
                                    5.h,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // 작성 년도 월 일
                                          inputYT(
                                            displayDate.replaceAll('일 ', '일\n'),
                                            12,
                                          ),
                                          // 기록된 타이머
                                          inputYT(displayTimer, 15),
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            30.r,
                                          ),
                                          color: const Color(0XFFFFFFFF),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 54.h,
                                        child: Text(
                                          '  $memo',
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
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
        borderRadius: BorderRadius.circular(15.r),
        color: dayColors,
      ),
      width: 35.w,
      height: 30.h,
      child: Text(
        day,
        style: TextStyle(
          fontSize: 15.sp,
          color: Colors.black,
          decoration: isDay ? TextDecoration.underline : TextDecoration.none,
          decorationColor: Colors.blue, // 밑줄 색
          decorationThickness: 2,
        ),
      ),
    );
  }

  Container inputYT(String title, double size) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0Xffffffff),
        border: Border.all(color: Colors.black),
      ),
      width: 140.w,
      height: 40.h,
      child: Text(
        title,
        style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
      ),
    );
  }
}
