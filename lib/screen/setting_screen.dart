import 'package:flutter/material.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';
import 'package:pif_frontend/screen/setting/alamsetting.dart';
import 'package:pif_frontend/screen/setting/appinfosetting.dart';
import 'package:pif_frontend/screen/setting/infosetting.dart';
import 'package:pif_frontend/screen/setting/languagesetting.dart';
import 'package:pif_frontend/screen/setting/themesetting.dart';
import 'package:pif_frontend/screen/setting/usersetting.dart';
import 'package:pif_frontend/screen/setting/versionsetting.dart';
import 'package:pif_frontend/utils/functions.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43),
        child: PifAppbar(
          titlename: '설정',
          isMenu: true,
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
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              padding: const EdgeInsets.fromLTRB(2, 16, 2, 12),
              decoration: BoxDecoration(
                color: Color(0x8CFFFFFF),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 750,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    padding: const EdgeInsets.fromLTRB(2, 16, 2, 12),
                    decoration: BoxDecoration(
                      color: Color(0xB3B6EFEA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '고객지원',
                              style: TextStyle(
                                color: Color(0xCC146467),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          settingrow('공지사항'),
                          SizedBox(height: 5),
                          settingrow('고객센터'),
                          SizedBox(height: 5),
                          settingrow('자주 묻는 질문(FAQ)'),
                          SizedBox(height: 5),
                          settingrow('문의하기 / 1:1 상담'),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    padding: const EdgeInsets.fromLTRB(2, 16, 2, 12),
                    decoration: BoxDecoration(
                      color: Color(0xB3B6EFEA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '앱 정보',
                              style: TextStyle(
                                color: Color(0xCC146467),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              openScreen(
                                context,
                                (context) => Appinfosetting(),
                              );
                            },
                            child: settingrow('어플리케이션 정보'),
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {
                              openScreen(
                                context,
                                (context) => Versionsetting(),
                              );
                            },
                            child: settingrow('버전 정보 & 업데이트 확인'),
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {
                              openScreen(context, (context) => Usersetting());
                            },
                            child: settingrow('이용약관'),
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {
                              openScreen(context, (context) => Infosetting());
                            },
                            child: settingrow('개인정보 처리방침'),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    padding: const EdgeInsets.fromLTRB(2, 16, 2, 12),
                    decoration: BoxDecoration(
                      color: Color(0xB3B6EFEA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '기타',
                              style: TextStyle(
                                color: Color(0xCC146467),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              openScreen(context, (context) => Themesetting());
                            },
                            child: settingrow('테마 설정'),
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {
                              openScreen(context, (context) => Alamsetting());
                            },
                            child: settingrow('알림 설정'),
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {
                              openScreen(
                                context,
                                (context) => Languagesetting(),
                              );
                            },
                            child: settingrow('언어 설정'),
                          ),
                          SizedBox(height: 5),
                          settingrow('실험실'),
                          SizedBox(height: 5),
                        ],
                      ),
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

  Row settingrow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF146467),
            fontWeight: FontWeight.bold,
          ),
        ),
        Image.asset(
          'assets/images/addicon/setting_arrow.png',
          width: 15,
          height: 15,
        ),
      ],
    );
  }
}
