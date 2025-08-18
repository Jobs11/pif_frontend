import 'package:flutter/material.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/bar/pif_sidbar.dart';

import 'package:pif_frontend/dialog/show_writer_post.dart';
import 'package:pif_frontend/model/post.dart';
import 'package:pif_frontend/model/record.dart';
import 'package:pif_frontend/service/postservice.dart';
import 'package:pif_frontend/service/recordservice.dart';
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

  late Future<List<Post>> posts;

  final Map<int, Future<Records>> _recordFutureCache = {};

  final Set<int> _openPostIds = <int>{};

  void _toggleComments(Post post) {
    setState(() {
      if (_openPostIds.contains(post.pNum)) {
        _openPostIds.remove(post.pNum);
      } else {
        _openPostIds.add(post.pNum!);
      }
    });
  }

  Future<Records> _getRecordOnce(int rnum) {
    return _recordFutureCache.putIfAbsent(
      rnum,
      () => Recordservice.recordGet(rnum), // int rnum 그대로
    );
  }

  @override
  void initState() {
    super.initState();
    posts = Postservice.getPostList("공개");
  }

  void refreshlist() {
    setState(() {
      posts = Postservice.getPostList("공개");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43),
        child: PifAppbar(
          titlename: '기억 속 이야기',
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
                      GestureDetector(
                        onTap: () {
                          refreshlist();
                        },
                        child: searchbt('새로고침'),
                      ),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: GestureDetector(
                      onTap: () {
                        showWriterPost(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 214, 252, 227),
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: double.infinity,
                        height: 24,
                        child: Text(
                          '오늘의 하루는 어떠셨나요?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(height: 540, child: newlist()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<Post>> newlist() {
    return FutureBuilder<List<Post>>(
      future: posts, // ← 서버 호출 Future (포스트 목록)
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('불러오기 실패: ${snapshot.error}'));
        }

        final items = snapshot.data ?? const <Post>[];
        if (items.isEmpty) {
          return const Center(child: Text('기록이 없습니다.'));
        }

        return ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 13),
          itemBuilder: (context, index) {
            final p = items[index];
            final rnum = p.rNum; // ← p에서 rnum 추출 (필드명에 맞게 수정)

            final isOpen = _openPostIds.contains(p.pNum);

            return FutureBuilder<Records>(
              future: _getRecordOnce(rnum),
              builder: (context, rSnap) {
                if (rSnap.connectionState == ConnectionState.waiting) {
                  // 셀 단위 로딩 UI
                  return const ListTile(
                    title: Text('불러오는 중...'),
                    subtitle: LinearProgressIndicator(),
                  );
                }
                if (rSnap.hasError) {
                  // 재시도 버튼 + 캐시 무효화
                  return ListTile(
                    title: const Text('상세 불러오기 실패'),
                    subtitle: Text('${rSnap.error}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {
                          _recordFutureCache.remove(rnum);
                        });
                      },
                    ),
                  );
                }

                final r = rSnap.data!; // ← rnum으로 가져온 상세 데이터

                // 여기서 p(요약/목록 데이터) + r(상세 데이터)로 원하는 위젯을 조립
                // Hascomment/Uncomment가 p,r을 필요로 한다면 생성자에 맞춰 전달하세요.
                return isOpen
                    ? Hascomment(
                        p: p,
                        r: r,
                        onToggle: () => _toggleComments(p),
                      ) // 예시: 커스텀 위젯에 주입
                    : Uncomment(
                        p: p,
                        r: r,
                        onToggle: () => _toggleComments(p),
                      ); // 예시: 커스텀 위젯에 주입
              },
            );
          },
        );
      },
    );
  }
}
