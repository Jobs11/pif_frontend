import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';

class Appinfosetting extends StatelessWidget {
  const Appinfosetting({super.key});

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
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 앱 아이콘 & 이름
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/addicon/logo.png',
                        width: 70.w,
                        height: 70.h,
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PIF",
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "버전 1.0.0",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // 앱 설명
                  Text(
                    "PIF는 사용자의 행동을 시간 단위로 기록하고\n"
                    "이를 기반으로 다른 사람들과 소통할 수 있는 SNS입니다.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.sp, height: 1.5.h),
                  ),
                  SizedBox(height: 20.h),

                  // 버튼 3개
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // 이용약관 페이지 이동
                      },
                      child: const Text("이용약관"),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // 개인정보 처리방침 페이지 이동
                      },
                      child: const Text("개인정보 처리방침"),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // 업데이트 확인 로직
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("최신 버전입니다.")),
                        );
                      },
                      child: const Text("업데이트 확인"),
                    ),
                  ),

                  SizedBox(height: 20.h),
                  const Text(
                    "© 2025 PIF Team",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
