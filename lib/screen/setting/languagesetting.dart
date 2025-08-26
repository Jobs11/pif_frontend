import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';

class Languagesetting extends StatefulWidget {
  const Languagesetting({super.key});

  @override
  State<Languagesetting> createState() => _LanguagesettingState();
}

class _LanguagesettingState extends State<Languagesetting> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _selectedLanguage = "korean";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43.h),
        child: PifAppbar(
          titlename: '언어 설정',
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
              margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0.h),
              padding: EdgeInsets.fromLTRB(2.w, 16.h, 2.w, 12.h),
              decoration: BoxDecoration(
                color: Color(0x8CFFFFFF),
                borderRadius: BorderRadius.circular(12.r),
              ),
              height: 750.h,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0.h),
                      padding: EdgeInsets.fromLTRB(2.w, 16.h, 2.w, 12.h),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Column(
                        children: [
                          // 시스템 기본 설정
                          selectradio('한국어', 'Korean'),
                          const Divider(),
                          // 라이트 테마
                          selectradio('English', 'English'),
                          const Divider(),
                          // 다크 테마
                          selectradio('日本語', 'Japanese'),
                          const Divider(),
                          // 레트로 테마
                          selectradio('简体中文 (Simplified)', 'Simplified'),
                          const Divider(),
                          // 차분 테마
                          selectradio('繁體中文 (Traditional)', 'Traditional'),
                          const Divider(),
                          // 에너지 테마
                          selectradio('Español', 'Spanish'),
                          const Divider(),
                          // 에너지 테마
                          selectradio('Português', 'Portuguese'),
                          const Divider(),
                          // 에너지 테마
                          selectradio('Français', 'French'),
                          const Divider(),
                          // 에너지 테마
                          selectradio('Deutsch', 'German'),
                          const Divider(),
                          // 에너지 테마
                          selectradio('Русский', 'Russian'),
                        ],
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

  RadioListTile<String> selectradio(String title, String value) {
    return RadioListTile(
      title: Text(title),
      value: value,
      groupValue: _selectedLanguage,
      activeColor: Colors.teal,
      onChanged: (value) {
        setState(() => _selectedLanguage = value!);
      },
    );
  }

  Text decotext(String title) => Text(
    title,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 20.sp),
  );
}
