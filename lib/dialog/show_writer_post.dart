import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pif_frontend/dialog/list_memory.dart';
import 'package:pif_frontend/model/currentuser.dart';
import 'package:pif_frontend/model/post.dart';
import 'package:pif_frontend/screen/sns_screen.dart';
import 'package:pif_frontend/service/postservice.dart';

Future<void> showWriterPost(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: _PostWriterDialog(),
    ),
  );
}

class _PostWriterDialog extends StatefulWidget {
  const _PostWriterDialog();

  @override
  State<_PostWriterDialog> createState() => _DailyTraceDialogState();
}

class _DailyTraceDialogState extends State<_PostWriterDialog> {
  String _scope = '공개';
  final contentController = TextEditingController();
  String? _selectedTime;
  String? _selectedMemo;
  int? _selectedNum;

  Future<void> _register() async {
    final post = Post(
      pId: CurrentUser.instance.member!.mId,
      rNum: _selectedNum!,
      pContent: contentController.text.trim(),
      pPublic: _scope,
    );

    try {
      await Postservice.registerP(post); // 서버는 200/201만 주면 OK

      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "작성 완료!",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );

      // 성공 시에만 페이지 이동
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => SnsScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "가입 실패! $e",
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
        borderRadius: BorderRadius.circular(24.r),
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
              '기억 속 이야기 작성',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 프로필 + 공개 범위
                      Row(
                        children: [
                          Image.asset(
                            CurrentUser.instance.member?.mPaint ??
                                'assets/images/addicon/user.png',
                            width: 16.w,
                            height: 16.h,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            CurrentUser.instance.member!.mName,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(999.r),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _scope, // ✅ items 중 하나여야 함
                                isDense: true,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16.sp,
                                ),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black87,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: '공개',
                                    child: Text('공개'),
                                  ),
                                  DropdownMenuItem(
                                    value: '비공개',
                                    child: Text('비공개'),
                                  ),
                                ],
                                onChanged: (v) {
                                  if (v == null) return;
                                  setState(() => _scope = v); // ✅ 상태 업데이트
                                  // 필요하면 여기서 선택값 사용
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),

                      // 선택한 기억 라인
                      GestureDetector(
                        onTap: () async {
                          final selectedRecord = await listMemory(context);

                          if (selectedRecord != null) {
                            setState(() {
                              // 예: UI에 표시할 변수 저장
                              _selectedTime = selectedRecord.rTime;
                              _selectedMemo = selectedRecord.rDecoration;
                              _selectedNum = selectedRecord.rNum;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/addicon/clock.png',
                              width: 15.w,
                              height: 15.h,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              _selectedMemo ?? '선택한 기억',
                              style: TextStyle(fontSize: 13.sp),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // 본문 안내 텍스트(고정 표시)
                      Container(
                        constraints: BoxConstraints(minHeight: 180.h),
                        alignment: Alignment.topLeft,
                        child: TextField(
                          controller: contentController,
                          minLines: 5,
                          maxLines: 8,
                          style: TextStyle(
                            fontSize: 18.sp,
                            height: 1.5.h,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: '글을 작성해 주세요. (100자 이내)',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 12.h,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),
                      Container(
                        decoration: BoxDecoration(color: Color(0xFF000000)),
                        width: double.infinity,
                        height: 2.h,
                      ),
                      SizedBox(height: 8.h),

                      // 하단: 태그 + 게시 버튼
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/addicon/tag.png',
                                width: 15.w,
                                height: 15.h,
                              ),
                              SizedBox(width: 6.w),
                              Text('태그 추가', style: TextStyle(fontSize: 13.sp)),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              _register();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 18.w),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F5DC),
                                borderRadius: BorderRadius.circular(30.r),
                                border: Border.all(color: Colors.black),
                              ),
                              height: 20.h,
                              child: Text(
                                '게시',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 오른쪽 상단 타이머 칩(고정 텍스트)
                Positioned(
                  right: 14.w,
                  top: 20.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(999.r),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      _selectedTime ?? '00:00:00',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
