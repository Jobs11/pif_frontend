import 'package:flutter/material.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';

class Alamsetting extends StatefulWidget {
  const Alamsetting({super.key});

  @override
  State<Alamsetting> createState() => _AlamsettingState();
}

class _AlamsettingState extends State<Alamsetting> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isPush = false;
  bool _isSound = false;
  bool _isVibration = false;
  bool _iscomment = false;
  bool _isheart = false;
  bool _iscommentheart = false;
  bool _isnotice = false;
  bool _isevent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43),
        child: PifAppbar(
          titlename: '알림 설정',
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titletext('1. 휴대폰 알림'),
                          setswitch(
                            '푸시 알림',
                            '전체적인 알림을 켭니다.',
                            _isPush,
                            (val) => setState(() => _isPush = val),
                          ),

                          setswitch(
                            '소리 알림',
                            '알림의 소리를 켭니다.',
                            _isSound,
                            (val) => setState(() => _isSound = val),
                          ),
                          setswitch(
                            '진동 알림',
                            '알림의 진동을 켭니다.',
                            _isVibration,
                            (val) => setState(() => _isVibration = val),
                          ),
                        ],
                      ),
                      const Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titletext('2. SNS 알림'),
                          setswitch(
                            '댓글 알림',
                            '내 기록에 댓글이 달렸을 때 알림',
                            _iscomment,
                            (val) => setState(() => _iscomment = val),
                          ),

                          setswitch(
                            '좋아요 알림',
                            '다른 사용자가 내 게시글에 좋아요를 눌렀을 때 알림',
                            _isheart,
                            (val) => setState(() => _isheart = val),
                          ),
                          setswitch(
                            '댓글 좋아요 알림',
                            '다른 사용자가 내 댓글에 좋아요를 눌렀을 때 알림.',
                            _iscommentheart,
                            (val) => setState(() => _iscommentheart = val),
                          ),
                        ],
                      ),
                      const Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titletext('3. 시스템/서비스 알림'),
                          setswitch(
                            '공지사항 알림',
                            '새로운 공지/업데이트 소식을 전할 때 알림',
                            _isnotice,
                            (val) => setState(() => _isnotice = val),
                          ),

                          setswitch(
                            '이벤트 알림',
                            '앱 내 이벤트, 챌린지 참여 알림',
                            _isevent,
                            (val) => setState(() => _isevent = val),
                          ),
                        ],
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

  SwitchListTile setswitch(
    String title,
    String subtitle,
    bool v,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      value: v,
      activeColor: Colors.teal,
      onChanged: onChanged,
    );
  }

  Text titletext(String title) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}
