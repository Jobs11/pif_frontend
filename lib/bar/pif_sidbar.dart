import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_frontend/model/currentuser.dart';
import 'package:pif_frontend/screen/profile_screen.dart';
import 'package:pif_frontend/screen/setting_screen.dart';
import 'package:pif_frontend/screen/sns_screen.dart';
import 'package:pif_frontend/screen/storage_screen.dart';
import 'package:pif_frontend/screen/timer_screen.dart';

class PifSidbar extends StatelessWidget {
  const PifSidbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // ← 사이드바
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background/pif_side.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              CurrentUser.instance.member?.mPaint ??
                                  'assets/images/addicon/user.png',
                              fit: BoxFit.cover,
                              width: 90.w,
                              height: 90.h,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              CurrentUser.instance.member?.mNickname ?? "손님",
                              style: TextStyle(
                                color: Color(0xFF146467),
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 오른쪽 상단에 들어갈 아이콘
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            // 눌렀을 때 동작
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingScreen(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/addicon/setting.png', // 넣고 싶은 이미지 경로
                            width: 30.w,
                            height: 30.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/addicon/stopwatch.png',
                    width: 20.w,
                    height: 20.h,
                  ),
                  title: Text(
                    '기억 타이머',
                    style: TextStyle(
                      color: Color(0xFF146467),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TimerScreen()),
                    ); // 닫기
                    // 홈 화면 이동
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/addicon/storage.png',
                    width: 20.w,
                    height: 20.h,
                  ),
                  title: Text(
                    '기억의 서랍',
                    style: TextStyle(
                      color: Color(0xFF146467),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StorageScreen()),
                    );
                    // 설정 화면 이동
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/addicon/sns.png',
                    width: 20.w,
                    height: 20.h,
                  ),
                  title: Text(
                    '기억 속 이야기',
                    style: TextStyle(
                      color: Color(0xFF146467),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SnsScreen()),
                    );
                    // 설정 화면 이동
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/addicon/home.png',
                    width: 20.w,
                    height: 20.h,
                  ),
                  title: Text(
                    '기억의 주인',
                    style: TextStyle(
                      color: Color(0xFF146467),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                    // 설정 화면 이동
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
