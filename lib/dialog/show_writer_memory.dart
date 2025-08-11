import 'package:flutter/material.dart';

Future<void> showMemoryInputDialog(
  BuildContext context, {
  String? initialTimerText, // 예: "00시간 00분 00초"
  void Function(String date, String content)? onSave,
}) async {
  final theme = Theme.of(context);
  DateTime? pickedDate;
  String dateDisplay = '20xx. xx. xx';
  final contentController = TextEditingController();

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
            Future<void> pickDate() async {
              final now = DateTime.now();
              final DateTime? d = await showDatePicker(
                context: context,
                initialDate: pickedDate ?? now,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (d != null) {
                setState(() {
                  pickedDate = d;
                  dateDisplay =
                      '${d.year}.${d.month.toString().padLeft(2, '0')}.${d.day.toString().padLeft(2, '0')}';
                });
              }
            }

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
                                        GestureDetector(
                                          onTap: pickDate,
                                          child: Container(
                                            height: 36,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFF8E7),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                color: Colors.black87,
                                                width: 1,
                                              ),
                                            ),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              dateDisplay,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
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
                                            initialTimerText ?? '00시간 00분 00초',
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
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFDCAB),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: Colors.black),
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

class _PillButton extends StatelessWidget {
  final String label;
  final bool filled;
  final VoidCallback onPressed;
  const _PillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    final bg = filled ? const Color(0xFF2B6C73) : Colors.white;
    final fg = filled ? Colors.white : const Color(0xFF2B6C73);

    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
            side: BorderSide(color: const Color(0xFF2B6C73), width: 1.5),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
