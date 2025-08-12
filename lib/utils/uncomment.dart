import 'package:flutter/material.dart';

class Uncomment extends StatelessWidget {
  const Uncomment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 145,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFFFFF8E7),
        border: Border.all(color: Colors.black),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(11.5, 10, 11.5, 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 25,
                  // 프로필 사진 이름
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/character/crab.png',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 12,
                            child: Text(
                              '이름',
                              style: TextStyle(fontSize: 8),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          SizedBox(
                            height: 12,
                            child: Text(
                              '0 시간전',
                              style: TextStyle(fontSize: 8),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 타이머 시간
                Container(
                  alignment: Alignment.center,
                  width: 57,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Color(0xFFE0E0E0),
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text('00:00:00', style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
            SizedBox(height: 6.5),

            // 기록 관련
            Row(
              children: [
                Image.asset(
                  'assets/images/addicon/clock.png',
                  width: 15,
                  height: 15,
                ),
                SizedBox(width: 4.5),
                SizedBox(
                  width: 50,
                  height: 15,
                  child: Text('기록', style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
            SizedBox(height: 6.5),

            // 흔적 내용
            SizedBox(
              width: 358,
              height: 36,
              child: Text('오늘도 기록 완료', style: TextStyle(fontSize: 15)),
            ),
            SizedBox(height: 6.5),
            Container(
              decoration: BoxDecoration(color: Color(0xFF000000)),
              width: double.infinity,
              height: 2,
            ),
            SizedBox(height: 6.5),

            // 좋아요 및 댓글
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/addicon/e_heart.png',
                      width: 15,
                      height: 15,
                    ),
                    SizedBox(width: 15),
                    SizedBox(
                      width: 38,
                      height: 15,
                      child: Text('00', style: TextStyle(fontSize: 12)),
                    ),
                    SizedBox(width: 12),
                    Image.asset(
                      'assets/images/addicon/messenger.png',
                      width: 15,
                      height: 15,
                    ),
                    SizedBox(width: 15),
                    SizedBox(
                      width: 38,
                      height: 15,
                      child: Text('00', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 55,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFFFC8C8),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        '삭제',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 7.5),

                    Container(
                      alignment: Alignment.center,
                      width: 55,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFD8E7FF),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        '취소',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
