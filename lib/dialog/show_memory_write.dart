import 'package:flutter/material.dart';

void showMemoryWrite(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '배경',
    barrierColor: Color(0xCC000000),
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent, // 흰색 배경 제거
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // 둥근 모서리
        ),
        content: SizedBox(
          width: 380,
          height: 500,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/background/pif_dialog_500.png',
                  fit: BoxFit.cover,
                ),
              ),
              // 상단 타이틀 (배경 안쪽)
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF146467),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // 본문 내용
              Positioned(
                top: 120,
                left: 24,
                child: SizedBox(
                  width: 280,
                  height: 50,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '기억 날짜',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF026565),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 120,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF8E7),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  '20xx년 xx월 xx일',
                                  style: TextStyle(color: Color(0xFF026565)),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '기억 타이머',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF026565),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 120,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF8E7),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  '00시간 00분 00초',
                                  style: TextStyle(color: Color(0xFF026565)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '기억 내용',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF026565),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 320,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF8E7),
                              border: Border.all(color: Colors.black),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder
                                    .none, // 테두리 제거 (BoxDecoration에서 그림)
                                hintText: '기억할 내용을 입력해주세요.', // 플레이스홀더
                              ),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 하단 확인 버튼 (배경 안쪽)
              Positioned(
                right: 16,
                bottom: 16,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    backgroundColor: const Color(0xFF146467).withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    '확인',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
