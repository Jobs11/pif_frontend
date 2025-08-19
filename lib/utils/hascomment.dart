import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pif_frontend/model/comment.dart';
import 'package:pif_frontend/model/currentuser.dart';
import 'package:pif_frontend/model/heart.dart';

import 'package:pif_frontend/model/member.dart';
import 'package:pif_frontend/model/post.dart';
import 'package:pif_frontend/model/record.dart';
import 'package:pif_frontend/screen/sns_screen.dart';
import 'package:pif_frontend/service/heartservice.dart';
import 'package:pif_frontend/service/commentservice.dart';
import 'package:pif_frontend/service/memberservice.dart';
import 'package:pif_frontend/service/postservice.dart';
import 'package:pif_frontend/utils/commentlist.dart';
import 'package:pif_frontend/utils/functions.dart';

class Hascomment extends StatefulWidget {
  final Post p;
  final Records r;
  final VoidCallback onToggle;
  final VoidCallback onRefresh;

  const Hascomment({
    super.key,
    required this.p,
    required this.r,
    required this.onToggle,
    required this.onRefresh,
  });

  @override
  State<Hascomment> createState() => _HascommentState();
}

class _HascommentState extends State<Hascomment> {
  int cmLength = 0;
  late Future<List<Comment>> comments;
  late Future<Member> member;
  late Future<int> countC;
  late Future<int> countH;
  late Future<int> countAllH;

  final commentController = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    comments = Commentservice.getCommentList(widget.p.pNum!);
    member = Memberservice.userdata(widget.p.pId);
    countC = Commentservice.countComment(widget.p.pNum!);
    countH = Heartservice.countHeart(
      CurrentUser.instance.member!.mId,
      widget.p.pNum!,
    );

    countAllH = Heartservice.countAllHeart(widget.p.pNum!);

    comments.then((list) {
      setState(() {
        cmLength = list.length;
      });
    });
  }

  Future<void> _toggleHeart(int pNum, int h) async {
    if (h != 0) {
      await _delete(pNum);
    } else {
      await _registerh(pNum);
    }
    // Future 다시 실행 → UI 새로 그림
    setState(() {
      countH = Heartservice.countHeart(
        CurrentUser.instance.member!.mId,
        widget.p.pNum!,
      );
      countAllH = Heartservice.countAllHeart(widget.p.pNum!);
    });
  }

  Future<void> _register() async {
    setState(() => _loading = true);

    final comment = Comment(
      cId: CurrentUser.instance.member!.mId,
      cGetnum: widget.p.pNum!,
      cContent: commentController.text.trim(),
    );

    try {
      await Commentservice.registerC(comment); // 서버는 200/201만 주면 OK

      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "작성 완료!",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => SnsScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );

      // 성공 시에만 페이지 이동
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "작성 실패! $e",
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

  Future<void> _registerh(int pNum) async {
    setState(() => _loading = true);

    final heart = Heart(hId: CurrentUser.instance.member!.mId, hNum: pNum);

    try {
      await Heartservice.registerH(heart); // 서버는 200/201만 주면 OK

      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "게시글 좋아요!",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "에러 $e",
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

  Future<void> _delete(int pNum) async {
    setState(() => _loading = true);

    final heart = Heart(hId: CurrentUser.instance.member!.mId, hNum: pNum);

    try {
      await Heartservice.deleteH(heart); // 서버는 200/201만 주면 OK

      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "게시글 좋아요 취소!",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "에러 $e",
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

  Future<void> _deleteP(int pNum) async {
    setState(() => _loading = true);

    try {
      await Postservice.deleteP(pNum); // 서버는 200/201만 주면 OK

      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "게시글 삭제!",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "에러 $e",
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
    return Container(
      width: 380,
      height: (cmLength > 1) ? 340 : 265,
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

          final member = snapshot.data!;

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
                            member.mPaint ?? 'assets/images/addicon/user.png',
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
                                  member.mName,
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
                        FutureBuilder<int>(
                          future: countH,
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

                            final h = snapshot.data!;

                            return GestureDetector(
                              onTap: () => _toggleHeart(widget.p.pNum!, h),
                              child: Image.asset(
                                (h != 0)
                                    ? 'assets/images/addicon/f_heart.png'
                                    : 'assets/images/addicon/e_heart.png',
                                width: 15,
                                height: 15,
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 15),
                        FutureBuilder<int>(
                          future: countAllH,
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

                            final h = snapshot.data!;

                            return SizedBox(
                              width: 38,
                              height: 15,
                              child: Text(
                                h.toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          },
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
                        SizedBox(
                          width: 38,
                          height: 15,
                          child: Text(
                            cmLength.toString(),
                            style: TextStyle(fontSize: 12),
                          ),
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
                          GestureDetector(
                            onTap: () {
                              _deleteP(widget.p.pNum!);
                              widget.onRefresh();
                            },
                            child: Container(
                              alignment: Alignment.topCenter,
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
                              '수정',
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
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
                        child: FutureBuilder<List<Comment>>(
                          future: comments, // ← 서버 호출 Future
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

                            final items = snapshot.data ?? const <Comment>[];
                            if (items.isEmpty) {
                              return const Center(child: Text('댓글이 없습니다.'));
                            }

                            return ListView.separated(
                              itemCount: items.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 13),
                              itemBuilder: (context, index) {
                                final c = items[index];

                                return Commentlist(c: c);
                              },
                            );
                          },
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
                                CurrentUser.instance.member!.mPaint ??
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
                                    controller: commentController,
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
                              GestureDetector(
                                onTap: () {
                                  _register();
                                },
                                child: Container(
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
          );
        },
      ),
    );
  }
}
