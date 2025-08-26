import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pif_frontend/model/currentuser.dart';
import 'package:pif_frontend/model/member.dart';
import 'package:pif_frontend/screen/profile_screen.dart';
import 'package:pif_frontend/service/memberservice.dart';

Future<String?> profileUpdate(BuildContext context) {
  return showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: _ProfileUpdateDialog(),
    ),
  );
}

class _ProfileUpdateDialog extends StatefulWidget {
  const _ProfileUpdateDialog();

  @override
  State<_ProfileUpdateDialog> createState() => __ProfileUpdateDialogState();
}

class __ProfileUpdateDialogState extends State<_ProfileUpdateDialog> {
  final m = CurrentUser.instance.member;

  Future<void> _update(String img) async {
    final member = Member(
      mName: m!.mName,
      mNickname: m!.mNickname,
      mBirth: m!.mBirth,
      mPhone: m!.mPhone,
      mEmail: m!.mEmail,
      mId: m!.mId,
      mPassword: m!.mPassword,
      mPaint: img,
    );

    try {
      await Memberservice.updateProfile(member); // 서버는 200/201만 주면 OK

      CurrentUser.instance.member = member;

      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "프로필 사진 변경 완료!",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );

      // 성공 시에만 창내리고 페이지 이동
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => ProfileScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "프로필 사진 변경 실패! $e",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    const cardBg = Color(0xFFFFF8E7);

    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(
            'assets/images/background/pif_dialog_500.png',
          ), // 배경 이미지 경로
          fit: BoxFit.cover, // 화면 꽉 채우기
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 헤더 타이틀
            Text(
              '프로필 사진 목록',
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w800,
                color: Colors.teal.shade900,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 16.h),

            // 본문 카드
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(color: Colors.black),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 12.h),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
                    child: SizedBox(
                      height: 580.h,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                clickProfile(
                                  'assets/images/character/crab.png',
                                ),
                                SizedBox(width: 20.w),

                                clickProfile(
                                  'assets/images/character/fish.png',
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                clickProfile(
                                  'assets/images/character/hermitcrab.png',
                                ),
                                SizedBox(width: 20.w),

                                clickProfile(
                                  'assets/images/character/shellfish.png',
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                clickProfile(
                                  'assets/images/character/shrimp.png',
                                ),
                                SizedBox(width: 20.w),

                                clickProfile(
                                  'assets/images/character/turtle.png',
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                clickProfile(
                                  'assets/images/character/seaurchin.png',
                                ),

                                SizedBox(width: 20.w),
                                clickProfile(
                                  'assets/images/character/seasquirt.png',
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                clickProfile(
                                  'assets/images/character/seaanemone.png',
                                ),

                                SizedBox(width: 20.w),
                                clickProfile(
                                  'assets/images/character/octopus.png',
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                clickProfile(
                                  'assets/images/character/shark.png',
                                ),

                                SizedBox(width: 20.w),
                                clickProfile(
                                  'assets/images/character/whale.png',
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // 오른쪽 상단 타이머 칩(고정 텍스트)
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector clickProfile(String img) {
    return GestureDetector(
      onTap: () {
        _update(img);
        Navigator.pop(context);
      },
      child: Image.asset(img, width: 120.w, height: 120.h),
    );
  }
}
