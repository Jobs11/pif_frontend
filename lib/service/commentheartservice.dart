import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pif_frontend/model/commentheart.dart';
import 'package:pif_frontend/model/heart.dart';

class Commentheartservice {
  static const String baseUrl = "http://192.168.0.94:8888/pif/commentheart";
  static const String registerHeart = "register";
  static const String getHeart = "getHeart";
  static const String getCount = "getCount";
  static const String getMyCount = "getMyCount";
  static const String deleteHeart = "delete";

  static Future<void> registerH(Commentheart commentheart) async {
    final url = Uri.parse("$baseUrl/$registerHeart");
    final res = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode(commentheart.toJson()),
        )
        .timeout(const Duration(seconds: 10));

    // 디버깅에 도움되도록 응답 본문 포함
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception("Register failed: ${res.statusCode} ${res.body}");
    }
  }

  static Future<void> deleteH(Commentheart commentheart) async {
    final url = Uri.parse("$baseUrl/$deleteHeart");
    final res = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode(commentheart.toJson()),
        )
        .timeout(const Duration(seconds: 10));

    // 디버깅에 도움되도록 응답 본문 포함
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception("Register failed: ${res.statusCode} ${res.body}");
    }
  }

  static Future<int> countMyHeart(String chId) async {
    // GET 요청 → URL에 파라미터로 전달
    final url = Uri.parse(
      "$baseUrl/$getMyCount",
    ).replace(queryParameters: {'ch_id': chId});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json.toInt();
    }

    throw Exception('로그인 실패: ${response.statusCode}');
  }

  static Future<int> countHeart(String chId, int chNum) async {
    // GET 요청 → URL에 파라미터로 전달
    final url = Uri.parse(
      "$baseUrl/$getHeart",
    ).replace(queryParameters: {'ch_id': chId, 'ch_num': chNum.toString()});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json.toInt();
    }

    throw Exception('로그인 실패: ${response.statusCode}');
  }

  static Future<int> countAllHeart(int chNum) async {
    // GET 요청 → URL에 파라미터로 전달
    final url = Uri.parse(
      "$baseUrl/$getCount",
    ).replace(queryParameters: {'ch_num': chNum.toString()});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json.toInt();
    }

    throw Exception('로그인 실패: ${response.statusCode}');
  }
}
