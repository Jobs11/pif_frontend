import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pif_frontend/dialog/list_memory.dart';
import 'package:pif_frontend/model/currentuser.dart';
import 'package:pif_frontend/model/post.dart';
import 'package:pif_frontend/service/postservice.dart';

Future<void> showWriterPost(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => const Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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

  bool _loading = false;

  Future<void> _register() async {
    setState(() => _loading = true);

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
        fontSize: 16.0,
      );

      // 성공 시에만 페이지 이동
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "가입 실패! $e",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
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
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 헤더 타이틀
            Text(
              '기억 속 이야기 작성',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Colors.teal.shade900,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 16),

            // 본문 카드
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.black),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 프로필 + 공개 범위
                      Row(
                        children: [
                          Image.asset(
                            CurrentUser.instance.member?.mPaint ??
                                'assets/images/addicon/user.png',
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            CurrentUser.instance.member!.mName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _scope, // ✅ items 중 하나여야 함
                                isDense: true,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16,
                                ),
                                style: const TextStyle(
                                  fontSize: 12,
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
                      const SizedBox(height: 14),

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
                              width: 15,
                              height: 15,
                            ),
                            SizedBox(width: 6),
                            Text(
                              _selectedMemo ?? '선택한 기억',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 본문 안내 텍스트(고정 표시)
                      Container(
                        constraints: const BoxConstraints(minHeight: 180),
                        alignment: Alignment.topLeft,
                        child: TextField(
                          controller: contentController,
                          minLines: 5,
                          maxLines: 8,
                          style: const TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                          decoration: const InputDecoration(
                            hintText: '글을 작성해 주세요. (100자 이내)',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(color: Color(0xFF000000)),
                        width: double.infinity,
                        height: 2,
                      ),
                      const SizedBox(height: 8),

                      // 하단: 태그 + 게시 버튼
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/addicon/tag.png',
                                width: 15,
                                height: 15,
                              ),
                              SizedBox(width: 6),
                              Text('태그 추가', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              _register();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F5DC),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.black),
                              ),
                              height: 20,
                              child: const Text(
                                '게시',
                                style: TextStyle(
                                  fontSize: 15,
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
                  right: 14,
                  top: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      _selectedTime ?? '00:00:00',
                      style: const TextStyle(
                        fontSize: 12,
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
