import 'dart:convert';
import 'package:crypinvest/backend/services/api_endpoint.dart';
import 'package:http/http.dart' as http;

import 'language_model.dart';

class LanguageService {
  Future<List<Language>> fetchLanguages() async {
    final response = await http.get(Uri.parse(ApiEndpoint.languagesURL));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> languageDataList = data["data"]["languages"];
      final List<Language> languages =
          languageDataList.map((json) => Language.fromJson(json)).toList();
      return languages;
    } else {
      throw Exception('Failed to load language data');
    }
  }
}
