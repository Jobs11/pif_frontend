import 'package:flutter/material.dart';
import 'package:pif_frontend/model/currentuser.dart';
import 'package:pif_frontend/model/member.dart';
import 'package:pif_frontend/model/post.dart';
import 'package:pif_frontend/model/record.dart';
import 'package:pif_frontend/service/commentservice.dart';
import 'package:pif_frontend/service/memberservice.dart';
import 'package:pif_frontend/utils/functions.dart';

class Uncomment extends StatefulWidget {
  final Post p;
  final Records r;
  final VoidCallback onToggle;

  const Uncomment({
    super.key,
    required this.p,
    required this.r,
    required this.onToggle,
  });

  @override
  State<Uncomment> createState() => _UncommentState();
}

class _UncommentState extends State<Uncomment> {
  late Future<Member> member;
  late Future<int> countC;

  @override
  void initState() {
    super.initState();
    member = Memberservice.userdata(widget.p.pId);
    countC = Commentservice.countComment(widget.p.pNum!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFFFFF8E7),
        border: Border.all(color: Colors.black),
      ),
      child: FutureBuilder<Member>(
        future: member,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('오류 발생: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('데이터 없음'));
          }

          final m = snapshot.data!;

          return Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
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
                            m.mPaint ?? 'assets/images/addicon/user.png',
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
                                  m.mName,
                                  style: TextStyle(fontSize: 8),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              SizedBox(
                                height: 12,
                                child: Text(
                                  hoursAgoFromMysql(widget.p.pRegisterdate!),
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
                      width: 80,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Color(0xFFE0E0E0),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        widget.r.rTime,
                        style: TextStyle(fontSize: 10),
                      ),
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
                      child: Text(
                        widget.r.rDecoration,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.5),

                // 흔적 내용
                SizedBox(
                  width: 358,
                  height: 36,
                  child: Text(
                    widget.p.pContent,
                    style: TextStyle(fontSize: 15),
                  ),
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
                        GestureDetector(
                          onTap: () {
                            widget.onToggle();
                          },
                          child: Image.asset(
                            'assets/images/addicon/messenger.png',
                            width: 15,
                            height: 15,
                          ),
                        ),
                        SizedBox(width: 15),
                        FutureBuilder<int>(
                          future: countC,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('오류 발생: ${snapshot.error}'),
                              );
                            }
                            if (!snapshot.hasData) {
                              return const Center(child: Text('데이터 없음'));
                            }

                            final c = snapshot.data!;

                            return SizedBox(
                              width: 38,
                              height: 15,
                              child: Text(
                                c.toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Visibility(
                      visible:
                          (widget.p.pId == CurrentUser.instance.member!.mId)
                          ? true
                          : false,
                      child: Row(
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
                              style: TextStyle(fontSize: 10),
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
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
