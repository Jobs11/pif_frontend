import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';

class Versionsetting extends StatelessWidget {
  const Versionsetting({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43.h),
        child: PifAppbar(
          titlename: '버전 정보',
          isMenu: false,
          isBack: false,
          isColored: Color(0xFFA0E4E7),
          onMenuPressed: () => scaffoldKey.currentState?.openDrawer(),
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
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(12.r),
              ),
              height: 300.h,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, // ← 위쪽 정렬
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("App Version", style: TextStyle(fontSize: 40.sp)),
                    SizedBox(height: 8.h),
                    Text(
                      "1.0.0", // ← 현재 버전 표시
                      style: TextStyle(
                        fontSize: 56.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    OutlinedButton(
                      onPressed: () {
                        // 업데이트 확인 로직 (예: 서버 버전 체크)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("최신 버전입니다.")),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 20.h,
                        ), // ← 버튼 크기 커짐
                        textStyle: TextStyle(fontSize: 20.sp), // ← 글자 크기도 키움
                      ),
                      child: const Text("Check for updates"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
