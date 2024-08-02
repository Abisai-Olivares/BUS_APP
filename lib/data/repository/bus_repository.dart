import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bus_model.dart';

class BusRepository {
  final String apiUrl;

  BusRepository({required this.apiUrl});

  Future<List<BusModel>> getAllBuses() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<BusModel>.from(l.map((model) => BusModel.fromJson(model)));
    } else {
      throw Exception('Failed to load buses');
    }
  }

    Future<void> updateBus(BusModel bus) async {
    final response = await http.put(
      Uri.parse('https://vm703q5lua.execute-api.us-east-2.amazonaws.com/Prod/edit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(bus.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update bus');
    }
  }

  Future<void> deleteBus(int busId) async {
    final response = await http.delete(
      Uri.parse('https://vm703q5lua.execute-api.us-east-2.amazonaws.com/Prod/delete/$busId'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete bus');
    }
  }

    Future<void> addBus(BusModel bus) async {
     final response = await http.post(
      Uri.parse('https://vm703q5lua.execute-api.us-east-2.amazonaws.com/Prod/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(bus.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add bus');
    }
  }
  
}
