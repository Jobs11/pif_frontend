import 'package:flutter/material.dart';
import 'package:pif_frontend/model/comment.dart';
import 'package:pif_frontend/model/currentuser.dart';
import 'package:pif_frontend/model/member.dart';
import 'package:pif_frontend/service/memberservice.dart';
import 'package:pif_frontend/utils/functions.dart';

class Commentlist extends StatefulWidget {
  final Comment c;

  const Commentlist({super.key, required this.c});

  @override
  State<Commentlist> createState() => _CommentlistState();
}

class _CommentlistState extends State<Commentlist> {
  late Future<Member> member;

  @override
  void initState() {
    super.initState();
    member = Memberservice.userdata(widget.c.cId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(30),
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

          final member = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
            child: Row(
              children: [
                // 프로필 사진
                Image.asset(
                  member.mPaint ?? 'assets/images/addicon/user.png',
                  width: 28,
                  height: 28,
                ),
                SizedBox(width: 4.5),
                Column(
                  children: [
                    SizedBox(
                      width: 295,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 이름 및 좋아요
                          Row(
                            children: [
                              SizedBox(
                                width: 40,
                                height: 10,
                                child: Text(
                                  member.mName,
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
                                child: Text('1', style: TextStyle(fontSize: 8)),
                              ),
                              SizedBox(width: 3),
                              SizedBox(
                                width: 30,
                                height: 10,
                                child: Text(
                                  hoursAgoFromMysql(widget.c.cRegisterdate!),
                                  style: TextStyle(fontSize: 8),
                                ),
                              ),
                            ],
                          ),

                          // 삭제 및 취소 버튼
                          Visibility(
                            visible:
                                (widget.c.cId ==
                                    CurrentUser.instance.member!.mId)
                                ? true
                                : false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 22,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xFFFFC8C8),
                                    border: Border.all(color: Colors.black),
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
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xFFD8E7FF),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: const Text(
                                    '수정',
                                    style: TextStyle(fontSize: 6),
                                    textAlign: TextAlign.center, // 가로 중앙
                                  ),
                                ),
                              ],
                            ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          widget.c.cContent,
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.left,
                        ),
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
