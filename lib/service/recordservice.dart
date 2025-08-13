import 'dart:convert';

import 'package:pif_frontend/model/record.dart';
import 'package:http/http.dart' as http;

class Recordservice {
  static const String baseUrl = "http://192.168.0.94:8888/pif/record";
  static const String registerRecord = "register";
  static const String getListRecord = "getlist";
  static const String getRecord = "getrecord";
  static const String getAllRecord = "getalllist";
  static const String modifyRecord = "modify";
  static const String deleteRecord = "delete";

  static Future<void> registerR(Records record) async {
    final url = Uri.parse("$baseUrl/$registerRecord");
    final res = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode(record.toJson()),
        )
        .timeout(const Duration(seconds: 10));

    // 디버깅에 도움되도록 응답 본문 포함
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception("Register failed: ${res.statusCode} ${res.body}");
    }
  }

  static Future<List<Records>> getRecordList(String id, String date) async {
    List<Records> recordInstances = [];
    final url = Uri.parse(
      '$baseUrl/$getListRecord',
    ).replace(queryParameters: {'m_id': id, 'r_date': date});
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> records = jsonDecode(response.body);
      for (var record in records) {
        recordInstances.add(Records.fromJson(record));
      }
      return recordInstances;
    }
    throw Error();
  }

  static Future<Records> recordGet(int rnum) async {
    // GET 요청 → URL에 파라미터로 전달
    final url = Uri.parse(
      "$baseUrl/$getRecord",
    ).replace(queryParameters: {'r_num': rnum.toString()});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Records.fromJson(json);
    }

    throw Exception('로그인 실패: ${response.statusCode}');
  }

  static Future<List<Records>> getRecordAllList(String id) async {
    List<Records> recordInstances = [];
    final url = Uri.parse(
      '$baseUrl/$getAllRecord',
    ).replace(queryParameters: {'m_id': id});
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> records = jsonDecode(response.body);
      for (var record in records) {
        recordInstances.add(Records.fromJson(record));
      }
      return recordInstances;
    }
    throw Error();
  }
}
