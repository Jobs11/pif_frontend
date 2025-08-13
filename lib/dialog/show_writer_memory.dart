import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pif_frontend/model/currentuser.dart';
import 'package:pif_frontend/screen/timer_screen.dart';
import 'package:pif_frontend/service/recordservice.dart';
import 'package:pif_frontend/model/record.dart';

Future<void> showMemoryInputDialog(
  BuildContext context, {
  required String saveDate, // 예: "00시간 00분 00초"
  required String saveTime,
  // void Function(String date, String content)? onSave,
}) async {
  final contentController = TextEditingController();
  String hour = saveTime.toString().split(":")[0];
  String minute = saveTime.toString().split(":")[1];
  String second = saveTime.toString().split(":")[2];

  String plusTime = '$hour시간 $minute분 $second초';

  await showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: const Color(0xCC000000),
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        clipBehavior: Clip.antiAlias,
        content: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              width: 360, // 필요시 조절
              height: 640, // 필요시 조절 (이미지 비율에 맞게)
              child: Stack(
                children: [
                  // 배경 이미지
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/background/pif_dialog_500.png', // <- 배경 이미지 교체
                      fit: BoxFit.cover,
                    ),
                  ),

                  // 반투명 헤더 + 폼
                  Positioned.fill(
                    child: Column(
                      children: [
                        // 상단 반투명 헤더
                        Container(
                          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          padding: const EdgeInsets.symmetric(vertical: 12),

                          child: Text(
                            '기억 타이머 입력창',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF2B6C73),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 80),
                        // 폼 컨테이너 (반투명)
                        Container(
                          margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                          decoration: BoxDecoration(
                            color: Color(0x8CFFFFFF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 1행: 기억 날짜 / 기억 타이머
                              Row(
                                children: [
                                  // 기억 날짜
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '기억 날짜',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF2B6C73),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          height: 40,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFF8E7),
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                              color: Colors.black87,
                                              width: 1,
                                            ),
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            saveDate,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // 기억 타이머
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '기억 타이머',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF2B6C73),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          height: 40,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFF8E7),
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                              color: Colors.black87,
                                              width: 1,
                                            ),
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            plusTime,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // 2행: 기억 내용 라벨
                              const Text(
                                '기억 내용',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF2B6C73),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // 3행: 내용 박스(멀티라인)
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF8E7),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Colors.black87,
                                    width: 1,
                                  ),
                                ),
                                child: TextField(
                                  controller: contentController,
                                  minLines: 5,
                                  maxLines: 8,
                                  style: const TextStyle(fontSize: 14),
                                  decoration: const InputDecoration(
                                    hintText: '간단하게 기억할 내용을 입력해주세요.',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // 버튼 2개
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        _registerFromDialog(
                                          context,
                                          CurrentUser.instance.member!.mId,
                                          saveDate,
                                          plusTime,
                                          contentController.text.trim(),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFDCAB),
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          '저장',
                                          style: TextStyle(
                                            color: Color(0xFF5A3A1A),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        // 설정 화면 이동
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFDCAB),
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          '취소',
                                          style: TextStyle(
                                            color: Color(0xFF5A3A1A),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

Future<void> _registerFromDialog(
  BuildContext dialogContext,
  String mId1,
  String rDate1,
  String rTime1,
  String rDecoration1,
) async {
  final record = Records(
    mId: mId1,
    rDate: rDate1,
    rTime: rTime1,
    rDecoration: rDecoration1,
  );

  try {
    await Recordservice.registerR(record);

    // 다이얼로그 닫기
    Navigator.pop(dialogContext, true); // true = 가입 성공

    Fluttertoast.showToast(
      msg: "작성 완료!",
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xAA000000),
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // 다이얼로그 닫은 후 페이지 이동
    // Navigator.pushReplacement(
    //   dialogContext,
    //   MaterialPageRoute(builder: (_) => TimerScreen()),
    // );
  } catch (e) {
    Navigator.pop(dialogContext, false); // false = 가입 실패

    Fluttertoast.showToast(
      msg: "작성 실패! $e",
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xAA000000),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
