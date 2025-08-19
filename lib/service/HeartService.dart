import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pif_frontend/model/heart.dart';

class Heartservice {
  static const String baseUrl = "http://192.168.0.94:8888/pif/heart";
  static const String registerHeart = "register";
  static const String getHeart = "getHeart";
  static const String getCount = "getCount";
  static const String getMyCount = "getMyCount";
  static const String getTopCount = "getTopCount";
  static const String deleteHeart = "delete";

  static Future<void> registerH(Heart heart) async {
    final url = Uri.parse("$baseUrl/$registerHeart");
    final res = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode(heart.toJson()),
        )
        .timeout(const Duration(seconds: 10));

    // 디버깅에 도움되도록 응답 본문 포함
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception("Register failed: ${res.statusCode} ${res.body}");
    }
  }

  static Future<void> deleteH(Heart heart) async {
    final url = Uri.parse("$baseUrl/$deleteHeart");
    final res = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode(heart.toJson()),
        )
        .timeout(const Duration(seconds: 10));

    // 디버깅에 도움되도록 응답 본문 포함
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception("Register failed: ${res.statusCode} ${res.body}");
    }
  }

  static Future<int> countMyHeart(String hId) async {
    // GET 요청 → URL에 파라미터로 전달
    final url = Uri.parse(
      "$baseUrl/$getMyCount",
    ).replace(queryParameters: {'h_id': hId});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json.toInt();
    }

    throw Exception('로그인 실패: ${response.statusCode}');
  }

  static Future<int> countHeart(String hId, int hNum) async {
    // GET 요청 → URL에 파라미터로 전달
    final url = Uri.parse(
      "$baseUrl/$getHeart",
    ).replace(queryParameters: {'h_id': hId, 'h_num': hNum.toString()});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json.toInt();
    }

    throw Exception('로그인 실패: ${response.statusCode}');
  }

  static Future<int> countAllHeart(int hNum) async {
    // GET 요청 → URL에 파라미터로 전달
    final url = Uri.parse(
      "$baseUrl/$getCount",
    ).replace(queryParameters: {'h_num': hNum.toString()});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json.toInt();
    }

    throw Exception('로그인 실패: ${response.statusCode}');
  }

  // static Future<List<int>> getTopHeartPosts() async {
  //   final response = await http.get(Uri.parse("$baseUrl/$getTopCount"));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = jsonDecode(response.body);
  //     return data.map((e) => e as int).toList();
  //   } else {
  //     throw Exception("Failed to load top hearts");
  //   }
  // }
}
