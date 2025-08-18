import 'dart:convert';

import 'package:pif_frontend/model/post.dart';
import 'package:http/http.dart' as http;

class Postservice {
  static const String baseUrl = "http://192.168.0.94:8888/pif/post";
  static const String registerPost = "register";
  static const String getPost = "getlist";
  static const String modifyPost = "modify";
  static const String deletePost = "delete";
  static const String getMyCount = "getMyCount";

  static Future<void> registerP(Post post) async {
    final url = Uri.parse("$baseUrl/$registerPost");
    final res = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode(post.toJson()),
        )
        .timeout(const Duration(seconds: 10));

    // 디버깅에 도움되도록 응답 본문 포함
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception("Register failed: ${res.statusCode} ${res.body}");
    }
  }

  static Future<List<Post>> getPostList(String pPublic) async {
    List<Post> postInstances = [];
    final url = Uri.parse(
      '$baseUrl/$getPost',
    ).replace(queryParameters: {'p_public': pPublic});
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> posts = jsonDecode(response.body);
      for (var post in posts) {
        postInstances.add(Post.fromJson(post));
      }
      return postInstances;
    }
    throw Error();
  }

  static Future<int> countPost(String pId) async {
    // GET 요청 → URL에 파라미터로 전달
    final url = Uri.parse(
      "$baseUrl/$getMyCount",
    ).replace(queryParameters: {'p_id': pId});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json.toInt();
    }

    throw Exception('로그인 실패: ${response.statusCode}');
  }
}
