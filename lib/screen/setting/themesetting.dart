import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        preferredSize: Size.fromHeight(43.h),
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
          // 배경
          Positioned.fill(
            child: Image.asset(
              'assets/images/background/pif_main.png',
              fit: BoxFit.cover,
            ),
          ),

          // 콘텐츠
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                child: Container(
                  padding: EdgeInsets.fromLTRB(2.w, 16.h, 2.w, 12.h),
                  decoration: BoxDecoration(
                    color: const Color(0x8CFFFFFF),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  // ✅ 고정 높이 제거 (height: 750 없앰)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ 섹션 1: 가운데 위치 + 내부 텍스트는 좌측 정렬
                      Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 480.w),
                          child: Padding(
                            padding: EdgeInsets.all(8.0.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '테마 변경 내역',
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                decotext('1. 글자 색상 변경'),
                                decotext('2. 내부 배경 색상 변경'),
                                decotext('3. 앱 바 색상 변경'),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // ✅ 섹션 2(라디오 리스트): 가운데 위치 + 폭 제한
                      Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 480.w),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0.h),
                            padding: EdgeInsets.fromLTRB(2.w, 16.h, 2.w, 12.h),
                            decoration: BoxDecoration(
                              color: const Color(0xB3FFFFFF),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Column(
                              children: [
                                selectradio('시스템 기본 테마', 'system'),
                                const Divider(),
                                selectradio('라이트 테마', 'light'),
                                const Divider(),
                                selectradio('다크 테마', 'dark'),
                                const Divider(),
                                selectradio('레트로 테마', 'retro'),
                                const Divider(),
                                selectradio('차분 테마', 'calm'),
                                const Divider(),
                                selectradio('에너지 테마', 'energy'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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

  Text decotext(String title) => Text(
    title,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 20.sp),
  );
}
