import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';

class Infosetting extends StatelessWidget {
  const Infosetting({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43.h),
        child: PifAppbar(
          titlename: '개인정보 처리방침',
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
                      padding: EdgeInsets.all(12.0.h),
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
                                  'PIF 개인정보 처리방침',
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            decotext(
                              '본 개인정보 처리방침은 사용자가 PIF 앱(이하 “서비스”)을 이용하는 과정에서 개인정보가 어떻게 취급되는지 설명합니다. 본 앱은 연습 및 학습 목적으로 제작된 것이며, 실제 개인정보를 수집하거나 보관하지 않습니다.',
                            ),
                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titletext('제1조 (개인정보의 수집 및 이용 목적)'),
                                SizedBox(height: 5.h),
                                decotext(
                                  '1. 본 서비스는 연습/학습 목적의 앱으로, 실제 개인정보를 수집하지 않습니다.',
                                ),
                                decotext(
                                  '2. 회원 가입, 로그인, 기록 작성 등은 모두 가상의 데이터 또는 사용자가 자율적으로 입력한 예시 데이터로 처리됩니다.',
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titletext('제2조 (수집하는 개인정보 항목)'),
                                SizedBox(height: 5.h),
                                decotext(
                                  '1. 본 서비스는 어떠한 개인정보(이름, 전화번호, 이메일 등)도 수집하지 않습니다.',
                                ),
                                decotext(
                                  '2. 다만, 사용자가 테스트 목적으로 입력하는 텍스트는 앱 내 로컬 데이터로만 활용됩니다.',
                                ),
                              ],
                            ),

                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titletext('제3조 (개인정보의 보관 및 파기)'),
                                SizedBox(height: 5.h),
                                decotext(
                                  '1. 실제 개인정보는 저장되지 않으므로 별도의 보관 및 파기 절차가 존재하지 않습니다.',
                                ),
                                decotext('2. 사용자가 입력한 데이터는 앱을 삭제하면 함께 제거됩니다.'),
                              ],
                            ),

                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titletext('제4조 (개인정보 제3자 제공)'),
                                SizedBox(height: 5.h),
                                decotext(
                                  '본 서비스는 어떠한 경우에도 개인정보를 제3자에게 제공하지 않습니다.',
                                ),
                              ],
                            ),

                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titletext('제5조 (개인정보 처리 위탁)'),
                                SizedBox(height: 5.h),
                                decotext('서비스 운영을 위해 개인정보를 위탁하지 않습니다.'),
                              ],
                            ),

                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titletext('제6조 (이용자의 권리)'),
                                SizedBox(height: 5.h),
                                decotext(
                                  '1. 사용자는 앱을 자유롭게 삭제할 수 있으며, 이와 함께 앱 내 기록도 삭제됩니다.',
                                ),
                                decotext('2. 별도의 회원 탈퇴 절차는 없습니다.'),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titletext('제7조 (책임 제한)'),
                                SizedBox(height: 5.h),
                                decotext(
                                  '1. 본 서비스는 학습/연습 목적의 데모 앱으로, 실제 개인정보 보호 법률상의 효력이 없습니다.',
                                ),
                                decotext(
                                  '2. 앱 제작자는 이용자가 입력한 데이터에 대해 법적 책임을 지지 않습니다.',
                                ),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titletext('제8조 (문의처)'),
                                SizedBox(height: 5.h),
                                decotext(
                                  '본 앱은 연습용으로 제작된 것이므로, 별도의 고객센터나 개인정보 보호 책임자는 없습니다.',
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
