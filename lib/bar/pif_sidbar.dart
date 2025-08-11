import 'package:flutter/material.dart';

class PifSidbar extends StatelessWidget {
  const PifSidbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // ← 사이드바
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background/pif_side.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/character/crab.png',
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                      Text(
                        '홍길동 님',
                        style: TextStyle(
                          color: Color(0xFF146467),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/addicon/stopwatch.png',
                    width: 20,
                    height: 20,
                  ),
                  title: Text(
                    '기억 타이머',
                    style: TextStyle(
                      color: Color(0xFF146467),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context); // 닫기
                    // 홈 화면 이동
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/addicon/storage.png',
                    width: 20,
                    height: 20,
                  ),
                  title: Text(
                    '기억의 서랍',
                    style: TextStyle(
                      color: Color(0xFF146467),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // 설정 화면 이동
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/addicon/sns.png',
                    width: 20,
                    height: 20,
                  ),
                  title: Text(
                    '하루의 흔적',
                    style: TextStyle(
                      color: Color(0xFF146467),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // 설정 화면 이동
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/addicon/home.png',
                    width: 20,
                    height: 20,
                  ),
                  title: Text(
                    '프로필 화면',
                    style: TextStyle(
                      color: Color(0xFF146467),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // 설정 화면 이동
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
