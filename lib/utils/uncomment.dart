import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pif_frontend/dialog/update_writer_post.dart';
import 'package:pif_frontend/model/currentuser.dart';
import 'package:pif_frontend/model/heart.dart';
import 'package:pif_frontend/model/member.dart';
import 'package:pif_frontend/model/post.dart';
import 'package:pif_frontend/model/record.dart';
import 'package:pif_frontend/service/heartservice.dart';
import 'package:pif_frontend/service/commentservice.dart';
import 'package:pif_frontend/service/memberservice.dart';
import 'package:pif_frontend/service/postservice.dart';
import 'package:pif_frontend/utils/functions.dart';

class Uncomment extends StatefulWidget {
  final Post p;
  final Records r;
  final VoidCallback onToggle;
  final VoidCallback onRefresh;

  const Uncomment({
    super.key,
    required this.p,
    required this.r,
    required this.onToggle,
    required this.onRefresh,
  });

  @override
  State<Uncomment> createState() => _UncommentState();
}

class _UncommentState extends State<Uncomment> {
  late Future<Member> member;
  late Future<int> countC;
  late Future<int> countH;
  late Future<int> countAllH;

  @override
  void initState() {
    super.initState();
    member = Memberservice.userdata(widget.p.pId);
    countC = Commentservice.countComment(widget.p.pNum!);
    countH = Heartservice.countHeart(
      CurrentUser.instance.member!.mId,
      widget.p.pNum!,
    );

    countAllH = Heartservice.countAllHeart(widget.p.pNum!);
  }

  Future<void> _toggleHeart(int pNum, int h) async {
    if (h != 0) {
      await _delete(pNum);
    } else {
      await _register(pNum);
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

  Future<void> _register(int pNum) async {
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
      height: 160.h,
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

          final m = snapshot.data!;

          return Padding(
            padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
            child: Column(
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
                            m.mPaint ?? 'assets/images/addicon/user.png',
                            width: 20.w,
                            height: 20.h,
                          ),
                          SizedBox(width: 8.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 12.h,
                                child: Text(
                                  m.mName,
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
                  height: 2.h,
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
                        SizedBox(width: 15.w),
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
                        SizedBox(width: 15.h),
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
                              width: 38.w,
                              height: 15.h,
                              child: Text(
                                c.toString(),
                                style: TextStyle(fontSize: 12.sp),
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
                          GestureDetector(
                            onTap: () {
                              _deleteP(widget.p.pNum!);
                              widget.onRefresh();
                            },
                            child: Container(
                              alignment: Alignment.center,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
