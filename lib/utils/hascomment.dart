import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pif_frontend/dialog/update_writer_post.dart';
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
        fontSize: 16.0.sp,
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
        fontSize: 16.0.sp,
      );
    } finally {}
  }

  Future<void> _registerh(int pNum) async {
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
        fontSize: 16.0.sp,
      );
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "에러 $e",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    } finally {}
  }

  Future<void> _delete(int pNum) async {
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
        fontSize: 16.0.sp,
      );
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "에러 $e",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    } finally {}
  }

  Future<void> _deleteP(int pNum) async {
    try {
      await Postservice.deleteP(pNum); // 서버는 200/201만 주면 OK

      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "게시글 삭제!",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "에러 $e",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      // height: (cmLength > 1) ? 340 : 265,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
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
            padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
            child: Column(
              // < 여기서 오버블로우
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 25.h,
                      // 프로필 사진 이름
                      child: Row(
                        children: [
                          Image.asset(
                            member.mPaint ?? 'assets/images/addicon/user.png',
                            width: 20.w,
                            height: 20.h,
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 12.h,
                                child: Text(
                                  member.mName,
                                  style: TextStyle(fontSize: 8.sp),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              SizedBox(
                                height: 12.h,
                                child: Text(
                                  hoursAgoFromMysql(widget.p.pRegisterdate!),
                                  style: TextStyle(fontSize: 8.sp),
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
                      width: 80.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: Color(0xFFE0E0E0),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        widget.r.rTime,
                        style: TextStyle(fontSize: 10.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.5.h),

                // 기록 관련
                Row(
                  children: [
                    Image.asset(
                      'assets/images/addicon/clock.png',
                      width: 15.w,
                      height: 15.h,
                    ),
                    SizedBox(width: 4.5.w),
                    SizedBox(
                      width: 50.w,
                      height: 15.h,
                      child: Text(
                        widget.r.rDecoration,
                        style: TextStyle(fontSize: 10.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.5.h),

                // 흔적 내용
                SizedBox(
                  width: 358.w,
                  height: 36.h,
                  child: Text(
                    widget.p.pContent,
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
                SizedBox(height: 6.5.h),
                Container(
                  decoration: BoxDecoration(color: Color(0xFF000000)),
                  width: double.infinity,
                  height: 2.w,
                ),
                SizedBox(height: 6.5.h),

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
                                width: 15.w,
                                height: 15.h,
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 15.h),
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
                              width: 38.w,
                              height: 15.h,
                              child: Text(
                                h.toString(),
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 12.w),
                        GestureDetector(
                          onTap: () {
                            widget.onToggle();
                          },
                          child: Image.asset(
                            'assets/images/addicon/messenger.png',
                            width: 15.w,
                            height: 15.h,
                          ),
                        ),
                        SizedBox(width: 15.w),
                        SizedBox(
                          width: 38.w,
                          height: 15.h,
                          child: Text(
                            cmLength.toString(),
                            style: TextStyle(fontSize: 12.sp),
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
                              width: 55.w,
                              height: 15.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.r),
                                color: Color(0xFFFFC8C8),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Text(
                                '삭제',
                                style: TextStyle(fontSize: 10.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(width: 7.5.w),

                          GestureDetector(
                            onTap: () {
                              updateWriterPost(context, widget.p, widget.r);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 55.w,
                              height: 15.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.r),
                                color: Color(0xFFD8E7FF),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Text(
                                '수정',
                                style: TextStyle(fontSize: 10.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.5.h),
                Container(
                  decoration: BoxDecoration(color: Color(0xFF000000)),
                  width: double.infinity,
                  height: 2.w,
                ),
                SizedBox(height: 14.h),
                Container(
                  width: 365.w,
                  height: (cmLength > 1) ? 165.h : 100.h,
                  decoration: BoxDecoration(color: Color(0x00FFFFFF)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: (cmLength > 1) ? 120.h : 55.h,
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
                                  SizedBox(height: 13.h),
                              itemBuilder: (context, index) {
                                final c = items[index];

                                return Commentlist(c: c);
                              },
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 13.5.h),

                      // 댓글 입력 구간
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 27.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: Color(0xFFFFFFFF),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(11.w, 2.h, 19.w, 2.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                CurrentUser.instance.member!.mPaint ??
                                    'assets/images/addicon/user.png',
                                width: 20.w,
                                height: 20.h,
                              ),
                              Container(
                                width: 270.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
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
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _register();
                                },
                                child: Container(
                                  width: 22.w,
                                  height: 15.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Color(0xFFF5F5DC),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Text(
                                    '게시',
                                    style: TextStyle(fontSize: 8.sp),
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
