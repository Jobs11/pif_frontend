import 'package:flutter/material.dart';
import 'package:pif_frontend/screen/member_screen.dart';
import 'package:pif_frontend/screen/timer_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지 (맨 아래)
          Positioned.fill(
            child: Image.asset(
              'assets/images/background/pif_login.png',
              fit: BoxFit.cover,
            ),
          ),
          // 내용 (텍스트 등)
          Center(
            // 타이틀 제목
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 170),
                Text(
                  "Plan Is Fun",
                  style: TextStyle(
                    fontSize: 64,
                    color: Color(0xFF146467),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // ...여기에 추가 위젯(로그인 폼 등) 넣기
                const SizedBox(height: 10), // 텍스트와 이미지 사이 여백

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/images/addicon/boat.png', // 원하는 이미지 경로
                      width: 60, // 필요시 크기 지정
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Image.asset(
                      'assets/images/addicon/beach.png', // 원하는 이미지 경로
                      width: 40, // 필요시 크기 지정
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                // 아이디 입력칸
                Container(
                  width: 302,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0x80FFFFFF),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: 250,
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder
                                  .none, // 테두리 제거 (BoxDecoration에서 그림)
                              hintText: 'ID', // 플레이스홀더
                            ),
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // 이미지 및 비밀번호 입력 칸
                SizedBox(
                  height: 95,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/images/addicon/starfish.png', // 원하는 이미지 경로
                            width: 60, // 필요시 크기 지정
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                      Positioned(
                        top: 20,
                        child: Row(
                          children: [
                            Container(
                              width: 302,
                              height: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0x80FFFFFF),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: SizedBox(
                                      width: 250,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder
                                              .none, // 테두리 제거 (BoxDecoration에서 그림)
                                          hintText: 'PASSWORD', // 플레이스홀더
                                        ),
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),
                // 로그인 버튼 칸
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TimerScreen()),
                    );
                  },
                  child: Container(
                    width: 302,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFF86DFD0),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '로그인',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // 회원가입 버튼 칸
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MemberScreen()),
                    );
                  },
                  child: Container(
                    width: 302,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0x0086DFD0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '회원가입',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF8FC7D0),
                            fontWeight: FontWeight.bold,
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
  }
}
