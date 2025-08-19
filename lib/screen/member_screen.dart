import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/model/member.dart';
import 'package:pif_frontend/screen/login_screens.dart';
import 'package:pif_frontend/service/memberservice.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({super.key});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  DateTime? selectedDate;
  bool showDropdown = false; // 드롭다운 표시 여부
  String? selectedValue;

  final nameController = TextEditingController();
  final nicknameController = TextEditingController();
  final phoneSController = TextEditingController();
  final phoneMController = TextEditingController();
  final phoneEController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final conpasswordController = TextEditingController();

  String birtdata = '';

  bool _loading = false;

  Future<void> _register() async {
    setState(() => _loading = true);

    final member = Member(
      mName: nameController.text.trim(),
      mNickname: nicknameController.text.trim(),
      mBirth: birtdata,
      mPhone:
          '${phoneSController.text.trim()}-${phoneMController.text.trim()}-${phoneEController.text.trim()}',
      mEmail: '${emailController.text.trim()}@$selectedValue',
      mId: idController.text.trim(),
      mPassword: passwordController.text.trim(),
    );

    try {
      await Memberservice.registerMember(member); // 서버는 200/201만 주면 OK

      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "가입 완료!",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // 성공 시에만 페이지 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "가입 실패! $e",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(), // 초기 날짜
      firstDate: DateTime(1990), // 선택 가능 최소 날짜
      lastDate: DateTime(2100), // 선택 가능 최대 날짜
      locale: const Locale('ko', 'KR'), // 한국어 설정
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birtdata =
            '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}';
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
                  membershipData(
                    '아이디 ( 15자 이내 )',
                    '아이디를 입력해주세요.',
                    15,
                    idController,
                  ),
                  SizedBox(height: 6),
                  membershipData(
                    '비밀번호 ( 15자 이내 )',
                    '비밀번호를 입력해주세요.',
                    15,
                    passwordController,
                  ),
                  SizedBox(height: 6),
                  membershipData(
                    '비밀번호 ( 15자 이내 )',
                    '비밀번호를 한번 더 입력해주세요.',
                    15,
                    conpasswordController,
                  ),
                  SizedBox(height: 6),
                  membershipData(
                    '이름 ( 10자 이내 )',
                    '이름을 입력해주세요.',
                    10,
                    nameController,
                  ),
                  SizedBox(height: 6),
                  membershipData(
                    '닉네임 ( 10자 이내 )',
                    '닉네임을 입력해주세요.',
                    10,
                    nicknameController,
                  ),
                  SizedBox(height: 6),
                  // 생년월일
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

                  // 휴대폰 번호
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
                                    child: TextFormField(
                                      controller: phoneSController,
                                      textAlign: TextAlign.center,
                                      maxLength: 3,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: InputBorder
                                            .none, // 테두리 제거 (BoxDecoration에서 그림)
                                        hintText: '010', // 플레이스홀더
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return '값을 입력해주세요.';
                                        }
                                        return null; // 검증 통과
                                      },
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
                                    child: TextFormField(
                                      controller: phoneMController,
                                      textAlign: TextAlign.center,
                                      maxLength: 4,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: InputBorder
                                            .none, // 테두리 제거 (BoxDecoration에서 그림)
                                        hintText: '1234', // 플레이스홀더
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return '값을 입력해주세요.';
                                        }
                                        return null; // 검증 통과
                                      },
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
                                    child: TextFormField(
                                      controller: phoneEController,
                                      textAlign: TextAlign.center,
                                      maxLength: 4,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: InputBorder
                                            .none, // 테두리 제거 (BoxDecoration에서 그림)
                                        hintText: '5678', // 플레이스홀더
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return '값을 입력해주세요.';
                                        }
                                        return null; // 검증 통과
                                      },
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
                  // 이메일
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
                                    child: TextFormField(
                                      controller: emailController,
                                      textAlign: TextAlign.center,
                                      maxLength: 15,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: InputBorder
                                            .none, // 테두리 제거 (BoxDecoration에서 그림)
                                        hintText: 'qwer1234', // 플레이스홀더
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return '값을 입력해주세요.';
                                        }
                                        return null; // 검증 통과
                                      },
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
                  GestureDetector(
                    onTap: () {
                      (passwordController.text == conpasswordController.text)
                          ? _register()
                          : Fluttertoast.showToast(
                              msg: "비밀번호가 서로 다릅니다.",
                              toastLength:
                                  Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
                              gravity: ToastGravity
                                  .BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
                              backgroundColor: const Color(
                                0xAA000000,
                              ), // 반투명 검정
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                    },
                    child: Container(
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column membershipData(
    String title,
    String hint,
    int textLength,
    TextEditingController controller,
  ) {
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
                  child: TextFormField(
                    controller: controller,
                    maxLength: textLength,
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none, // 테두리 제거 (BoxDecoration에서 그림)
                      hintText: hint, // 플레이스홀더
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return '값을 입력해주세요.';
                      }
                      return null; // 검증 통과
                    },
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
