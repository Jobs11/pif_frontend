import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:intl/intl.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';
import 'package:pif_frontend/dialog/show_writer_memory.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  static const plusTime = 0;
  int totalSeconds = plusTime;
  bool isRuning = false;
  late Timer timer;
  String startDate = '0000. 00. 00. 00:00:00';
  String giveDate = '20xx년 xx월 xx일 00시 00분 00초';
  String? year, month, day;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void onTick(Timer timer) {
    if (totalSeconds == 216000) {
      setState(() {
        isRuning = false;
        totalSeconds = plusTime;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds + 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(Duration(seconds: 1), onTick);

    final now = DateTime.now();

    Fluttertoast.showToast(
      msg: "타이머 시작",
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xAA000000),
      textColor: Colors.white,
      fontSize: 16.0.sp,
    );

    // print("year: $year, month: $month, day: $day");
    setState(() {
      isRuning = true;
      startDate = DateFormat('yyyy. MM. dd. HH:mm:ss').format(now);
      giveDate = DateFormat('yyyy년 MM월 dd일 HH시 mm분 ss초').format(now);
      year = startDate.toString().split(" ")[0].replaceAll(".", "");
      month = startDate.toString().split(" ")[1].replaceAll(".", "");
      day = startDate.toString().split(" ")[2].replaceAll(".", "");
    });
  }

  void onPausePressed() {
    timer.cancel();
    Fluttertoast.showToast(
      msg: "타이머 일시중지",
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xAA000000),
      textColor: Colors.white,
      fontSize: 16.0.sp,
    );
    setState(() {
      isRuning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    Fluttertoast.showToast(
      msg: "타이머 초기화",
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xAA000000),
      textColor: Colors.white,
      fontSize: 16.0.sp,
    );
    setState(() {
      isRuning = false;
      totalSeconds = plusTime;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43.h),
        child: PifAppbar(
          titlename: '기억 타이머',
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 타이머 구간
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/addicon/stop_interface.png',
                      width: 411.w, // 필요시 크기 지정
                      height: 360.h,
                      fit: BoxFit.cover,
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Text(
                        (totalSeconds != 0) ? format(totalSeconds) : '00:00:00',
                        style: TextStyle(
                          fontSize: 35.sp,
                          color: Color(0xFF146467),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                // 타이머 시작 날짜 시간
                Column(
                  children: [
                    Text(
                      '기억 흐르기 시작 시간',
                      style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF146467),
                      ),
                    ),

                    Text(
                      (totalSeconds != 0)
                          ? startDate
                          : '0000. 00. 00. 00:00:00',
                      style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF146467),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 75.h),
                // 시작과 중지와 일시 정지 버튼
                SizedBox(
                  width: 200.w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            isRuning ? onPausePressed() : onStartPressed();
                          },
                          child: Image.asset(
                            isRuning
                                ? 'assets/images/addicon/pause.png'
                                : 'assets/images/addicon/play.png',
                            width: 64.w, // 필요시 크기 지정
                            height: 64.h,
                            fit: BoxFit.cover,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            onResetPressed();
                          },
                          child: Image.asset(
                            'assets/images/addicon/reset.png',
                            width: 64.w, // 필요시 크기 지정
                            height: 64.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                // 기억 저장 버튼
                GestureDetector(
                  onTap: () {
                    isRuning
                        ? showWriterMemory(
                            context,
                            saveDate: isRuning
                                ? giveDate
                                : '20xx년 xx월 xx일 00시 00분 00초',
                            saveTime: format(totalSeconds),
                            // onSave: (date, content) {
                            //   // 저장 로직
                            // },
                          )
                        : Fluttertoast.showToast(
                            msg: "타이머 기억을 시작해주세요. ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: const Color(0xAA000000),
                            textColor: Colors.white,
                            fontSize: 16.0.h,
                          );
                    onResetPressed();
                  },
                  child: Container(
                    width: 244.w,
                    height: 38.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      color: Color(0xFFF9CC89),
                      border: Border.all(color: Color(0xFF000000)),
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      '기억 저장',
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: Color(0xFF5A3A1A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
