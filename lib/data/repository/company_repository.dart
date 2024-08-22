import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/company_model.dart';

class CompanyRepository {
  final String apiUrl = 'https://rjqka72vs5.execute-api.us-east-2.amazonaws.com/Prod/ships';

  CompanyRepository();

  Future<List<CompanyModel>> getAllCompanies() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<CompanyModel>.from(l.map((model) => CompanyModel.fromJson(model)));
    } else {
      throw Exception('Failed to load companies');
    }
  }
}
