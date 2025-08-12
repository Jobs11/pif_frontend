import 'package:pif_frontend/model/member.dart';

class CurrentUser {
  // 1) 프로그램 전체에서 딱 1개만 존재하는 instance
  static final CurrentUser instance = CurrentUser._internal();

  // 2) private 생성자 → 외부에서 new 불가
  CurrentUser._internal();

  // 3) 여기에 로그인한 유저 정보를 담음
  Member? member;
}
