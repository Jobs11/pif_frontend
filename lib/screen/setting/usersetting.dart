import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';

class Usersetting extends StatelessWidget {
  const Usersetting({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43.h),
        child: PifAppbar(
          titlename: '이용약관',
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
              height: 750.h,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12.0.w),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/addicon/document.png',
                                  width: 25.w,
                                  height: 25.h,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  'PIF 이용약관',
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titletext('1. 목적'),
                                SizedBox(height: 5.h),
                                decotext(
                                  '이 앱은 사용자가 자신의 행동을 시간 단위로 기록하고, 이를 토대로 다른 사람과 소통하는 연습용 SNS 기능을 제공합니다.',
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titletext('2. 회원 가입'),
                                SizedBox(height: 5.h),
                                decotext('- 앱은 연습용이므로 실제 개인정보는 사용되지 않습니다.'),

                                decotext('- 계정 생성은 자유롭게 할 수 있습니다.'),
                              ],
                            ),

                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titletext('3. 서비스 이용 규칙'),
                                SizedBox(height: 5.h),
                                decotext('- 기록은 자유롭게 작성할 수 있습니다.'),
                                decotext('- 욕설, 혐오 발언, 불법적인 내용은 금지됩니다.'),
                                decotext('- 다른 사람의 기록을 존중해야 합니다.'),
                              ],
                            ),

                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titletext('4. 콘텐츠 권리'),
                                SizedBox(height: 5.h),
                                decotext('- 사용자가 작성한 기록은 해당 사용자에게 귀속됩니다.'),
                                decotext('- 앱 제작자는 콘텐츠에 대해 소유권을 주장하지 않습니다.'),
                              ],
                            ),

                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titletext('5. 개인정보 보호'),
                                SizedBox(height: 5.h),
                                decotext('실제 서비스가 아니므로 개인정보는 수집·저장하지 않습니다.'),
                              ],
                            ),

                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titletext('6. 책임 제한'),
                                SizedBox(height: 5.h),
                                decotext('- 본 앱은 학습/연습 목적이며, 실제 법적 효력이 없습니다.'),
                                decotext(
                                  '- 이용 중 발생하는 문제에 대해 앱 제작자는 책임을 지지 않습니다.',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Color(0xFF000000),
                        border: Border.all(color: Color(0xFF000000)),
                      ),
                      width: 80.w,
                      height: 30.h,
                      child: Text(
                        '확인',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF),
                        ),
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

  Text titletext(String title) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
    );
  }

  Text decotext(String title) => Text(
    title,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 20.sp),
  );
}
