import 'package:flutter/material.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';

class Themesetting extends StatefulWidget {
  const Themesetting({super.key});

  @override
  State<Themesetting> createState() => _ThemesettingState();
}

class _ThemesettingState extends State<Themesetting> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedTheme = "system";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43),
        child: PifAppbar(
          titlename: '테마 설정',
          isMenu: false,
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
              margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
              padding: EdgeInsets.fromLTRB(2, 16, 2, 12),
              decoration: BoxDecoration(
                color: Color(0x8CFFFFFF),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 750,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                    padding: EdgeInsets.fromLTRB(2, 16, 2, 12),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        // 시스템 기본 설정
                        selectradio('시스템 기본 테마', 'system'),
                        const Divider(),
                        // 라이트 테마
                        selectradio('라이트 테마', 'light'),
                        const Divider(),
                        // 다크 테마
                        selectradio('다크 테마', 'dark'),
                        const Divider(),
                        // 레트로 테마
                        selectradio('레트로 테마', 'retro'),
                        const Divider(),
                        // 차분 테마
                        selectradio('차분 테마', 'calm'),
                        const Divider(),
                        // 에너지 테마
                        selectradio('에너지 테마', 'energy'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '테마 변경 내역',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        decotext('1. 글자 색상 변경'),
                        decotext('2. 내부 배경 색상 변경'),
                        decotext('3. 앱 바 색상 변경'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  RadioListTile<String> selectradio(String title, String value) {
    return RadioListTile(
      title: Text(title),
      value: value,
      groupValue: _selectedTheme,
      activeColor: Colors.teal,
      onChanged: (value) {
        setState(() => _selectedTheme = value!);
      },
    );
  }

  Text decotext(String title) =>
      Text(title, textAlign: TextAlign.start, style: TextStyle(fontSize: 20));
}
