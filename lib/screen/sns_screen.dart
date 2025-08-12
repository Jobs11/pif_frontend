import 'package:flutter/material.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';
import 'package:pif_frontend/utils/hascomment.dart';
import 'package:pif_frontend/utils/functions.dart';
import 'package:pif_frontend/utils/uncomment.dart';

class SnsScreen extends StatefulWidget {
  const SnsScreen({super.key});

  @override
  State<SnsScreen> createState() => _SnsScreenState();
}

class _SnsScreenState extends State<SnsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isComment = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43),
        child: PifAppbar(
          titlename: '하루의 흔적',
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
              height: 750,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xCCFFFFFF),
                      borderRadius: BorderRadius.circular(30), // 알약 모양
                      border: Border.all(
                        color: const Color(0xFF1B1B1B),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        // 입력
                        Expanded(
                          child: TextField(
                            maxLines: 1,
                            decoration: const InputDecoration(
                              hintText: '검색',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                            ),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),

                        // 오른쪽 둥근 아이콘 버튼
                        IconButton(
                          iconSize: 21,
                          padding: EdgeInsets.zero,
                          icon: Image.asset(
                            // 아이콘 이미지(있으면 사용)
                            'assets/images/addicon/magnifier.png',
                            // 없으면 아래 주석 해제해서 기본 아이콘 사용 가능:
                            // color: const Color(0xFF1B8D94),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 13.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      searchbt('새로고침'),
                      searchbt('좋아요'),
                      searchbt('자기 목록'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(color: Color(0xFF6AD9D4)),
                    width: double.infinity,
                    height: 6,
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 600,
                    child: ListView.separated(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return isComment ? Hascomment() : Uncomment();
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 13),
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
}
