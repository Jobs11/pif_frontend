import 'package:flutter/material.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({super.key});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  DateTime? selectedDate;
  bool showDropdown = false; // 드롭다운 표시 여부
  String? selectedValue;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(), // 초기 날짜
      firstDate: DateTime(2000), // 선택 가능 최소 날짜
      lastDate: DateTime(2100), // 선택 가능 최대 날짜
      locale: const Locale('ko', 'KR'), // 한국어 설정
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43),
        child: PifAppbar(
          titlename: '회원가입',
          isMenu: false,
          isBack: true,
          isColored: Color(0xFFA8EADF),
        ),
      ),

      body: Stack(
        children: [
          // 배경 이미지 (맨 아래)
          Positioned.fill(
            child: Image.asset(
              'assets/images/background/pif_ms.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  membershipData('아이디 ( 15자 이내 )', '아이디를 입력해주세요.', 15),
                  SizedBox(height: 6),
                  membershipData('비밀번호 ( 15자 이내 )', '비밀번호를 입력해주세요.', 15),
                  SizedBox(height: 6),
                  membershipData('비밀번호 ( 15자 이내 )', '비밀번호를 한번 더 입력해주세요.', 15),
                  SizedBox(height: 6),
                  membershipData('이름 ( 10자 이내 )', '이름을 입력해주세요.', 10),
                  SizedBox(height: 6),
                  membershipData('닉네임 ( 10자 이내 )', '닉네임을 입력해주세요.', 10),
                  SizedBox(height: 6),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '생년월일',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF026565),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 6),
                      Container(
                        width: 330,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0x80FFFFFF),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  selectedDate == null
                                      ? '0000-00-00'
                                      : '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Image.asset(
                                    'assets/images/addicon/calender.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '휴대폰',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF026565),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 106,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0x80FFFFFF),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  child: SizedBox(
                                    width: 60,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      maxLength: 3,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: InputBorder
                                            .none, // 테두리 제거 (BoxDecoration에서 그림)
                                        hintText: '010', // 플레이스홀더
                                      ),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 106,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0x80FFFFFF),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  child: SizedBox(
                                    width: 60,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      maxLength: 4,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: InputBorder
                                            .none, // 테두리 제거 (BoxDecoration에서 그림)
                                        hintText: '1234', // 플레이스홀더
                                      ),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 106,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0x80FFFFFF),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  child: SizedBox(
                                    width: 60,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      maxLength: 4,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: InputBorder
                                            .none, // 테두리 제거 (BoxDecoration에서 그림)
                                        hintText: '5678', // 플레이스홀더
                                      ),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '이메일',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF026565),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 140,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0x80FFFFFF),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  child: SizedBox(
                                    width: 90,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      maxLength: 15,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: InputBorder
                                            .none, // 테두리 제거 (BoxDecoration에서 그림)
                                        hintText: 'qwer1234', // 플레이스홀더
                                      ),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '@',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 160,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0x80FFFFFF),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  child: DropdownButton<String>(
                                    value: selectedValue,
                                    hint: Text('선택하세요'),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    items:
                                        [
                                              'gmail.com',
                                              'naver.com',
                                              'nate.com',
                                              'daum.net',
                                            ]
                                            .map(
                                              (item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(item),
                                              ),
                                            )
                                            .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value;
                                        showDropdown = false; // 선택 후 목록 닫기
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 304,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xCC86DFD0),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '회원가입',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

  Column membershipData(String title, String hint, int textLength) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, color: Color(0xFF026565)),
            ),
          ],
        ),
        SizedBox(height: 6),
        Container(
          width: 330,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0x80FFFFFF),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: SizedBox(
                  width: 280,
                  child: TextField(
                    maxLength: textLength,
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none, // 테두리 제거 (BoxDecoration에서 그림)
                      hintText: hint, // 플레이스홀더
                    ),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
