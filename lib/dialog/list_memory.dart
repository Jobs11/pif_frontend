import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_frontend/model/currentuser.dart';
import 'package:pif_frontend/model/record.dart';
import 'package:pif_frontend/service/recordservice.dart';

Future<Records?> listMemory(BuildContext context) {
  return showDialog<Records>(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: _ListMemoryDialog(),
    ),
  );
}

class _ListMemoryDialog extends StatefulWidget {
  const _ListMemoryDialog();

  @override
  State<_ListMemoryDialog> createState() => _ListMemoryDialogState();
}

class _ListMemoryDialogState extends State<_ListMemoryDialog> {
  late Future<List<Records>> records;

  @override
  void initState() {
    super.initState();
    records = Recordservice.getRecordAllList(CurrentUser.instance.member!.mId);
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
              '작성한 기억 목록',
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
                    padding: EdgeInsets.fromLTRB(15.w, 0, 15.h, 0),
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

                              return GestureDetector(
                                onTap: () {
                                  Navigator.pop(
                                    context,
                                    r,
                                  ); // r은 선택한 Records 객체
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFCCFAF8),

                                    border: Border.all(color: Colors.black),
                                  ),
                                  width: double.infinity,
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
                                            inputLM(
                                              displayDate.replaceAll(
                                                '일 ',
                                                '일 \n',
                                              ),
                                              10,
                                              140,
                                            ),
                                            // 기록된 타이머
                                            inputLM(displayTimer, 10, 80),
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
                                          height: 35.h,
                                          child: Text(
                                            '  $memo',
                                            style: TextStyle(fontSize: 15.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
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
}

Container inputLM(String title, double size, double wsize) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.r),
      color: Color(0Xffffffff),
      border: Border.all(color: Colors.black),
    ),
    width: wsize.w,
    height: 35.h,
    child: Text(
      title,
      style: TextStyle(fontSize: size.sp, fontWeight: FontWeight.bold),
    ),
  );
}
