import 'package:flutter/material.dart';
import 'package:pif_frontend/model/tempdata.dart';

class Hascomment extends StatefulWidget {
  const Hascomment({super.key});

  @override
  State<Hascomment> createState() => _HascommentState();
}

class _HascommentState extends State<Hascomment> {
  int cmLength = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: (cmLength > 1) ? 340 : 265,
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
            SizedBox(height: 6.5),
            Container(
              decoration: BoxDecoration(color: Color(0xFF000000)),
              width: double.infinity,
              height: 2,
            ),
            SizedBox(height: 14),
            Container(
              width: 365,
              height: (cmLength > 1) ? 165 : 100,
              decoration: BoxDecoration(color: Color(0x00FFFFFF)),
              child: Column(
                children: [
                  SizedBox(
                    height: (cmLength > 1) ? 120 : 55,
                    child: ListView.separated(
                      itemCount: cmLength,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          height: 54,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                            child: Row(
                              children: [
                                // 프로필 사진
                                Image.asset(
                                  'assets/images/character/shellfish.png',
                                  width: 28,
                                  height: 28,
                                ),
                                SizedBox(width: 4.5),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 295,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // 이름 및 좋아요
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 22,
                                                height: 10,
                                                child: Text(
                                                  '이름',
                                                  style: TextStyle(fontSize: 8),
                                                ),
                                              ),
                                              SizedBox(width: 3),
                                              Image.asset(
                                                'assets/images/addicon/f_heart.png',
                                                width: 7,
                                                height: 7,
                                              ),
                                              SizedBox(width: 5.5),
                                              SizedBox(
                                                width: 22,
                                                height: 10,
                                                child: Text(
                                                  '1',
                                                  style: TextStyle(fontSize: 8),
                                                ),
                                              ),
                                              SizedBox(width: 3),
                                              SizedBox(
                                                width: 22,
                                                height: 10,
                                                child: Text(
                                                  '1시간 전',
                                                  style: TextStyle(fontSize: 8),
                                                ),
                                              ),
                                            ],
                                          ),

                                          // 삭제 및 취소 버튼
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 22,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Color(0xFFFFC8C8),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                child: Text(
                                                  '삭제',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 6),
                                                ),
                                              ),
                                              SizedBox(width: 7.5),
                                              Container(
                                                width: 22,
                                                height: 10,

                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: const Color(
                                                    0xFFD8E7FF,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                child: const Text(
                                                  '수정',
                                                  style: TextStyle(fontSize: 6),
                                                  textAlign:
                                                      TextAlign.center, // 가로 중앙
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: 295,
                                      height: 23,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF6F6F6),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Text(
                                          '댓글이 재밌다....',
                                          style: TextStyle(fontSize: 10),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 13),
                    ),
                  ),

                  SizedBox(height: 13.5),

                  // 댓글 입력 구간
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFFFFFFFF),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(11, 2, 19, 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/addicon/user.png',
                            width: 20,
                            height: 20,
                          ),
                          Container(
                            width: 270,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFFF6F6F6),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: TextField(
                                maxLines: 1,
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: InputBorder
                                      .none, // 테두리 제거 (BoxDecoration에서 그림)
                                  hintText: '댓글을 입력해주세요.', // 플레이스홀더
                                ),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          Container(
                            width: 22,
                            height: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFF5F5DC),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Text(
                              '게시',
                              style: TextStyle(fontSize: 8),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
