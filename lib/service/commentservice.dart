import 'dart:convert';

import 'package:pif_frontend/model/comment.dart';
import 'package:http/http.dart' as http;

class Commentservice {
  static const String baseUrl = "http://192.168.0.94:8888/pif/comment";
  static const String registerComment = "register";
  static const String getList = "getlist";
  static const String getCount = "getcount";
  static const String getMyCount = "getMyCount";
  static const String modifyComment = "modify";
  static const String deleteComment = "delete";

  static Future<void> registerC(Comment comment) async {
    final url = Uri.parse("$baseUrl/$registerComment");
    final res = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode(comment.toJson()),
        )
        .timeout(const Duration(seconds: 10));

    // 디버깅에 도움되도록 응답 본문 포함
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception("Register failed: ${res.statusCode} ${res.body}");
    }
  }

  static Future<void> updatecomment(Comment comment) async {
    final url = Uri.parse("$baseUrl/$modifyComment");
    final res = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode(comment.toUpadate()),
        )
        .timeout(const Duration(seconds: 10));

    // 디버깅에 도움되도록 응답 본문 포함
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception("Register failed: ${res.statusCode} ${res.body}");
    }
  }

  static Future<List<Comment>> getCommentList(int cgetnum) async {
    List<Comment> commentInstances = [];
    final url = Uri.parse(
      '$baseUrl/$getList',
    ).replace(queryParameters: {'c_getnum': cgetnum.toString()});
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> comments = jsonDecode(response.body);
      for (var comment in comments) {
        commentInstances.add(Comment.fromJson(comment));
      }
      return commentInstances;
    }
    throw Error();
  }

  static Future<int> countComment(int cgetnum) async {
    // GET 요청 → URL에 파라미터로 전달
    final url = Uri.parse(
      "$baseUrl/$getCount",
    ).replace(queryParameters: {'c_getnum': cgetnum.toString()});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json.toInt();
    }

    throw Exception('로그인 실패: ${response.statusCode}');
  }

  static Future<int> countMyComment(String cId) async {
    // GET 요청 → URL에 파라미터로 전달
    final url = Uri.parse(
      "$baseUrl/$getMyCount",
    ).replace(queryParameters: {'c_id': cId});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json.toInt();
    }

    throw Exception('로그인 실패: ${response.statusCode}');
  }

  static Future<void> deleteC(int cNum) async {
    final url = Uri.parse("$baseUrl/$deleteComment");

    final res = await http.post(
      url,
      body: {'c_num': cNum.toString()}, // 요청 파라미터
    );

    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception("Register failed: ${res.statusCode} ${res.body}");
    }
  }
}
