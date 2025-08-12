import 'dart:convert';

import 'package:pif_frontend/model/member.dart';
import 'package:http/http.dart' as http;

class Memberservice {
  static const String baseUrl = "http://192.168.0.94:8888/pif/member";
  static const String registerUser = "register";
  static const String getUser = "getUser";
  static const String modifyUser = "modify";
  static const String deleteUser = "delete";

  static Future<void> registerMember(Member member) async {
    final url = Uri.parse("$baseUrl/$registerUser");
    final res = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode(member.toJson()),
        )
        .timeout(const Duration(seconds: 10));

    // 디버깅에 도움되도록 응답 본문 포함
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception("Register failed: ${res.statusCode} ${res.body}");
    }
  }

  static Future<Member> login(String id, String password) async {
    // GET 요청 → URL에 파라미터로 전달
    final url = Uri.parse(
      "$baseUrl/$getUser",
    ).replace(queryParameters: {'m_id': id, 'm_password': password});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Member.fromJson(json);
    }

    throw Exception('로그인 실패: ${response.statusCode}');
  }
}
