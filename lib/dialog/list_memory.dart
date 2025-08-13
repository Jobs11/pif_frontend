import 'package:flutter/material.dart';
import 'package:pif_frontend/model/currentuser.dart';
import 'package:pif_frontend/model/record.dart';
import 'package:pif_frontend/service/recordservice.dart';

Future<Records?> listMemory(BuildContext context) {
  return showDialog<Records>(
    context: context,
    barrierDismissible: true,
    builder: (_) => const Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
              '하루의 흔적 작성',
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
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SizedBox(
                      height: 580,
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
                                const SizedBox(height: 13),
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
                                    padding: const EdgeInsets.fromLTRB(
                                      15,
                                      6,
                                      15,
                                      5,
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
                                            inputLM(displayTimer, 15, 70),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                            color: const Color(0XFFFFFFFF),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          width: double.infinity,
                                          height: 35,
                                          child: Text(
                                            '  $memo',
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
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
      borderRadius: BorderRadius.circular(30),
      color: Color(0Xffffffff),
      border: Border.all(color: Colors.black),
    ),
    width: wsize,
    height: 35,
    child: Text(
      title,
      style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
    ),
  );
}
