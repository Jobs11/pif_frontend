import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';
import 'package:pif_frontend/model/currentuser.dart';
import 'package:pif_frontend/model/member.dart';
import 'package:pif_frontend/service/memberservice.dart';

class MemberUpdateScreen extends StatefulWidget {
  const MemberUpdateScreen({super.key});

  @override
  State<MemberUpdateScreen> createState() => _MemberUpdateScreenState();
}

class _MemberUpdateScreenState extends State<MemberUpdateScreen> {
  DateTime? selectedDate;
  bool showDropdown = false; // 드롭다운 표시 여부
  String? selectedValue;
  String? email1;
  String? phone1, phone2, phone3;

  final passwordController = TextEditingController();
  final conpasswordController = TextEditingController();

  final nameController = TextEditingController();
  final nicknameController = TextEditingController();
  final phoneSController = TextEditingController();
  final phoneMController = TextEditingController();
  final phoneEController = TextEditingController();
  final emailController = TextEditingController();

  String birtdata = '';

  @override
  void initState() {
    super.initState();

    email1 = CurrentUser.instance.member!.mEmail.split("@")[0];
    selectedValue = CurrentUser.instance.member!.mEmail.split("@")[1];

    phone1 = CurrentUser.instance.member!.mPhone.split("-")[0];
    phone2 = CurrentUser.instance.member!.mPhone.split("-")[1];
    phone3 = CurrentUser.instance.member!.mPhone.split("-")[2];

    passwordController.text = CurrentUser.instance.member!.mPassword;
    nameController.text = CurrentUser.instance.member!.mName;
    nicknameController.text = CurrentUser.instance.member!.mNickname;

    phoneSController.text = phone1!;
    phoneMController.text = phone2!;
    phoneEController.text = phone3!;

    emailController.text = email1!;

    // List<String> parts = CurrentUser.instance.member!.mBirth.split('-');
    // if (parts.length == 3) {
    //   String year = parts[0].padLeft(4, '0');
    //   String month = parts[1].padLeft(2, '0');
    //   String day = parts[2].padLeft(2, '0');

    //   birtdata = "$year-$month-$day"; // 2025-08-29
    // }

    //selectedDate = DateTime.parse(birtdata);
  }

  final m = CurrentUser.instance.member;

  Future<void> _update() async {
    final member = Member(
      mName: nameController.text.trim(),
      mNickname: nicknameController.text.trim(),
      mBirth: m!.mBirth,
      mPhone:
          '${phoneSController.text.trim()}-${phoneMController.text.trim()}-${phoneEController.text.trim()}',
      mEmail: '${emailController.text.trim()}@$selectedValue',
      mId: m!.mId,
      mPassword: passwordController.text.trim(),
      mPaint: m!.mPaint,
    );

    try {
      await Memberservice.updateMember(member);
      // 서버는 200/201만 주면 OK

      CurrentUser.instance.member = member;

      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "프로필 정보 변경 완료!",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // 성공 시에만 페이지 이동
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: "프로필 정보 변경 실패! $e",
        toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_LONG 가능
        gravity: ToastGravity.BOTTOM, // 위치 (TOP, CENTER, BOTTOM)
        backgroundColor: const Color(0xAA000000), // 반투명 검정
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {}
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate ?? DateTime.now(), // 초기 날짜
  //     firstDate: DateTime(2000), // 선택 가능 최소 날짜
  //     lastDate: DateTime(2100), // 선택 가능 최대 날짜
  //     locale: const Locale('ko', 'KR'), // 한국어 설정
  //   );
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //       birtdata =
  //           '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43),
        child: PifAppbar(
          titlename: '프로필 수정',
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
                  membershipInput(
                    '비밀번호',
                    '비밀번호를 입력해주세요.',
                    15,
                    passwordController,
                  ),
                  SizedBox(height: 6),
                  membershipInput(
                    '비밀번호 확인',
                    '비밀번호를 한번 더 입력해주세요.',
                    15,
                    conpasswordController,
                  ),
                  SizedBox(height: 6),
                  membershipInput('이름', '이름을 입력해주세요.', 10, nameController),
                  SizedBox(height: 6),
                  membershipInput(
                    '닉네임',
                    '닉네임을 입력해주세요.',
                    10,
                    nicknameController,
                  ),
                  SizedBox(height: 6),
                  // 생년월일
                  membershipData('생년월일', m!.mBirth),
                  SizedBox(height: 6),
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

                  SizedBox(height: 6),
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
                          ? _update()
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
                            '수정하기',
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

  Column membershipInput(
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

  Column membershipData(String title, String data) {
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
                  child: Text(data, style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
