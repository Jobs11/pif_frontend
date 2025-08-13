import 'dart:convert';

import 'package:pif_frontend/model/record.dart';
import 'package:http/http.dart' as http;

class Recordservice {
  static const String baseUrl = "http://192.168.0.94:8888/pif/record";
  static const String registerRecord = "register";
  static const String getRecord = "getlist";
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
      '$baseUrl/$getRecord',
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
}
