import 'package:flutter/material.dart';

Future<void> showMemoryInputDialog(
  BuildContext context, {
  String? saveDate, // 예: "00시간 00분 00초"
  String? saveTime,
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
                                          height: 36,
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
                                            saveDate ?? '20xx. xx. xx 00:00:00',
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
                                          height: 36,
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
                                            (saveTime == null)
                                                ? '00시간 00분 00초'
                                                : plusTime,
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
                                    hintText: '기억할 내용을 입력해주세요.',
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
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFDCAB),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: Colors.black),
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
