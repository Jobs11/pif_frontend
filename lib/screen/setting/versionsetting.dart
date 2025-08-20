import 'package:flutter/material.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';

class Versionsetting extends StatelessWidget {
  const Versionsetting({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43),
        child: PifAppbar(
          titlename: '버전 정보',
          isMenu: false,
          isBack: false,
          isColored: Color(0xFFA0E4E7),
          onMenuPressed: () => scaffoldKey.currentState?.openDrawer(),
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
              margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
              padding: EdgeInsets.fromLTRB(2, 16, 2, 12),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 300,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, // ← 위쪽 정렬
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("App Version", style: TextStyle(fontSize: 40)),
                    const SizedBox(height: 8),
                    const Text(
                      "1.0.0", // ← 현재 버전 표시
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: () {
                        // 업데이트 확인 로직 (예: 서버 버전 체크)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("최신 버전입니다.")),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ), // ← 버튼 크기 커짐
                        textStyle: const TextStyle(fontSize: 20), // ← 글자 크기도 키움
                      ),
                      child: const Text("Check for updates"),
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
