import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:intl/intl.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';
import 'package:pif_frontend/dialog/show_memory_write.dart';
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
  String? startDate;
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
    startDate = DateFormat('yyyy. MM. dd. HH:mm:ss').format(now);

    setState(() {
      isRuning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRuning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
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
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43),
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
                      width: 411, // 필요시 크기 지정
                      height: 360,
                      fit: BoxFit.cover,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                        (totalSeconds != 0) ? format(totalSeconds) : '00:00:00',
                        style: TextStyle(
                          fontSize: 35,
                          color: Color(0xFF146467),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // 타이머 시작 날짜 시간
                Column(
                  children: [
                    Text(
                      '기억 흐르기 시작 시간',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF146467),
                      ),
                    ),

                    Text(
                      (totalSeconds != 0)
                          ? '$startDate'
                          : '0000. 00. 00. 00:00:00',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF146467),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 75),
                // 시작과 중지와 일시 정지 버튼
                SizedBox(
                  width: 200,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
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
                            width: 64, // 필요시 크기 지정
                            height: 64,
                            fit: BoxFit.cover,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            onResetPressed();
                          },
                          child: Image.asset(
                            'assets/images/addicon/reset.png',
                            width: 64, // 필요시 크기 지정
                            height: 64,
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
                    // showMemoryWrite(context, 'dd', 'dd');
                    showMemoryInputDialog(
                      context,
                      initialTimerText: '01시간 23분 45초',
                      onSave: (date, content) {
                        // 저장 로직
                      },
                    );
                  },
                  child: Container(
                    width: 244,
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xFFF9CC89),
                      border: Border.all(color: Color(0xFF000000)),
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      '기억 저장',
                      style: TextStyle(
                        fontSize: 25,
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
