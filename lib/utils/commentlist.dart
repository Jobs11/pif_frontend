import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pif_frontend/model/comment.dart';
import 'package:pif_frontend/model/commentheart.dart';
import 'package:pif_frontend/model/currentuser.dart';
import 'package:pif_frontend/model/member.dart';
import 'package:pif_frontend/screen/sns_screen.dart';
import 'package:pif_frontend/service/commentheartservice.dart';
import 'package:pif_frontend/service/commentservice.dart';
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
  late Future<int> countCH;
  late Future<int> countAllCH;
  bool isOpen = false;
  final contentController = TextEditingController();

  final Set<int> _openCommentIds = <int>{};

  @override
  void initState() {
    super.initState();
    member = Memberservice.userdata(widget.c.cId);
    contentController.text = widget.c.cContent;
    countCH = Commentheartservice.countHeart(
      CurrentUser.instance.member!.mId,
      widget.c.cNum!,
    );

    countAllCH = Commentheartservice.countAllHeart(widget.c.cNum!);
  }

  void _toggleEdits(Comment comment) {
    setState(() {
      if (_openCommentIds.contains(comment.cNum)) {
        _openCommentIds.remove(comment.cNum);
        isOpen = _openCommentIds.contains(widget.c.cNum);
      } else {
        _openCommentIds.add(comment.cNum!);
        isOpen = _openCommentIds.contains(widget.c.cNum);
      }
    });
  }

  Future<void> _toggleHeart(int cNum, int ch) async {
    if (ch != 0) {
      await _delete(cNum);
    } else {
      await _register(cNum);
    }
    // Future 다시 실행 → UI 새로 그림
    setState(() {
      countCH = Commentheartservice.countHeart(
        CurrentUser.instance.member!.mId,
        widget.c.cNum!,
      );
      countAllCH = Commentheartservice.countAllHeart(widget.c.cNum!);
    });
  }

  Future<void> _register(int cNum) async {
    final commentheart = Commentheart(
      chId: CurrentUser.instance.member!.mId,
      chNum: cNum,
    );

    try {
      await Commentheartservice.registerH(commentheart); // 서버는 200/201만 주면 OK

      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "댓글 좋아요!",
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

  Future<void> _delete(int cNum) async {
    final commentheart = Commentheart(
      chId: CurrentUser.instance.member!.mId,
      chNum: cNum,
    );

    try {
      await Commentheartservice.deleteH(commentheart); // 서버는 200/201만 주면 OK

      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "댓글 좋아요 취소!",
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

  Future<void> _update() async {
    final ucomment = Comment(
      cId: widget.c.cId,
      cGetnum: widget.c.cGetnum,
      cContent: contentController.text.trim(),
      cNum: widget.c.cNum,
    );

    try {
      await Commentservice.updatecomment(ucomment);
      // 서버는 200/201만 주면 OK

      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "댓글 수정 완료!",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "댓글 수정 실패! $e",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    } finally {}
  }

  Future<void> _deletec(int cNum) async {
    try {
      await Commentservice.deleteC(cNum); // 서버는 200/201만 주면 OK

      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "댓글 삭제!",
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
      width: double.infinity,
      height: 54.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(30.r),
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
            padding: EdgeInsets.fromLTRB(5.w, 8.h, 5.w, 8.h),
            child: Row(
              children: [
                // 프로필 사진
                Image.asset(
                  member.mPaint ?? 'assets/images/addicon/user.png',
                  width: 28.w,
                  height: 28.h,
                ),
                SizedBox(width: 4.5.w),
                Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 295.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 이름 및 좋아요
                            Row(
                              children: [
                                SizedBox(
                                  width: 40.w,
                                  height: 10.h,
                                  child: Text(
                                    member.mName,
                                    style: TextStyle(fontSize: 8.sp),
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                FutureBuilder<int>(
                                  future: countCH,
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
                                      return const Center(
                                        child: Text('데이터 없음'),
                                      );
                                    }

                                    final h = snapshot.data!;

                                    return GestureDetector(
                                      onTap: () =>
                                          _toggleHeart(widget.c.cNum!, h),
                                      child: Image.asset(
                                        (h != 0)
                                            ? 'assets/images/addicon/f_heart.png'
                                            : 'assets/images/addicon/e_heart.png',
                                        width: 7.w,
                                        height: 7.h,
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(width: 5.5.w),
                                FutureBuilder<int>(
                                  future: countAllCH,
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
                                      return const Center(
                                        child: Text('데이터 없음'),
                                      );
                                    }

                                    final h = snapshot.data!;

                                    return SizedBox(
                                      width: 22.w,
                                      height: 10.h,
                                      child: Text(
                                        h.toString(),
                                        style: TextStyle(fontSize: 8.sp),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(width: 3.w),
                                SizedBox(
                                  width: 30.w,
                                  height: 10.h,
                                  child: Text(
                                    hoursAgoFromMysql(widget.c.cRegisterdate!),
                                    style: TextStyle(fontSize: 8.h),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _deletec(widget.c.cNum!);
                                    },
                                    child: Container(
                                      width: 22.w,
                                      height: 10.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          30.r,
                                        ),
                                        color: Color(0xFFFFC8C8),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Text(
                                        '삭제',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 6.sp),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 7.5.h),
                                  GestureDetector(
                                    onTap: () {
                                      _toggleEdits(widget.c);
                                    },
                                    child: Container(
                                      width: 22.w,
                                      height: 10.h,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          30.r,
                                        ),
                                        color: const Color(0xFFD8E7FF),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Text(
                                        '수정',
                                        style: TextStyle(fontSize: 6.sp),
                                        textAlign: TextAlign.center, // 가로 중앙
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: 295.w,
                        height: 23.h,
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: (isOpen)
                              ? editcontent()
                              : showcontent(widget.c.cContent),
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

  Text showcontent(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 10.sp),
      textAlign: TextAlign.left,
    );
  }

  Container editcontent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r), // 둥근 모서리
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8,
            offset: const Offset(0, 4), // 그림자 위치
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 텍스트 입력창
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "댓글을 입력하세요...",
                ),
                style: TextStyle(fontSize: 10.sp),
              ),
            ),
          ),

          // 저장 버튼
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _update();
                    _toggleEdits(widget.c);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF000000),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    width: 20.w,
                    height: 10.h,
                    child: Text(
                      '저장',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 5.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),

                // 취소 버튼
                GestureDetector(
                  onTap: () {
                    _toggleEdits(widget.c);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: Colors.black),
                    ),
                    width: 20.w,
                    height: 10.h,
                    child: Text(
                      '취소',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 5.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
