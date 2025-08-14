import 'package:flutter/material.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';
import 'package:pif_frontend/dialog/profile_update.dart';
import 'package:pif_frontend/model/currentuser.dart';

import 'package:pif_frontend/screen/member_update_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43),
        child: PifAppbar(
          titlename: '기억의 주인',
          isMenu: true,
          isBack: false,
          isColored: Color(0xFFA0E4E7),
          onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: PifSidbar(),
      body: Stack(
        children: [
          // 배경 이미지 (맨 아래)
          Positioned.fill(
            child: Image.asset(
              'assets/images/background/pif_main.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              padding: const EdgeInsets.fromLTRB(2, 16, 2, 12),
              decoration: BoxDecoration(
                color: Color(0x8CFFFFFF),
                borderRadius: BorderRadius.circular(12),
              ),
              width: 411,
              height: 750,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _isHovering = !_isHovering),
                      child: Stack(
                        alignment: Alignment.center, // 가운데 정렬 (필요에 맞게 수정)
                        children: [
                          // 배경 이미지
                          Image.asset(
                            CurrentUser.instance.member!.mPaint ??
                                'assets/images/addicon/user.png',
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          ),

                          // 겹칠 Column
                          if (_isHovering)
                            GestureDetector(
                              onTap: () async {
                                final profileimage = await profileUpdate(
                                  context,
                                );

                                if (profileimage != null) {
                                  setState(() {
                                    // 예: UI에 표시할 변수 저장
                                  });
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/addicon/camera.png',
                                    fit: BoxFit.cover,
                                    width: 70,
                                    height: 70,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    '편집',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black, // 배경 대비 위해 색 추가
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      CurrentUser.instance.member?.mNickname ?? "손님",
                      style: TextStyle(
                        color: Color(0xFF146467),
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(color: Color(0xFF000000)),
                      width: double.infinity,
                      height: 3,
                    ),
                    SizedBox(height: 15),
                    // 작성한 게시글 수
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                        color: Color.fromARGB(255, 233, 255, 254),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/addicon/post.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 20),
                            Text(
                              '작성한 게시글 수: ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 15),
                    // 좋아요 받은 게시글 수
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                        color: Color.fromARGB(255, 233, 255, 254),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/addicon/f_heart.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 20),
                            Text(
                              '게시글 좋아요 수: ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    // 작성한 댓글 수
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                        color: Color.fromARGB(255, 233, 255, 254),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/addicon/comment.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 20),
                            Text(
                              '작성한 댓글 수: ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    // 좋아요 받은 댓글 수
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                        color: Color.fromARGB(255, 233, 255, 254),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/addicon/f_heart.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 20),
                            Text(
                              '댓글 좋아요 수: ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(color: Color(0xFF000000)),
                      width: double.infinity,
                      height: 3,
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MemberUpdateScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black),
                          color: Color(0xFFF9CC89),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '프로필 수정',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
