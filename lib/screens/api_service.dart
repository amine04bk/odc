import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacexview/screens/model.dart';

class ApiService {
  final String apiUrl = 'https://api.spacexdata.com/v3/launches';

  Future<List<Data>> fetchLaunches() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((launch) => Data.fromJson(launch)).toList();
    } else {
      throw Exception('Failed to load launches');
    }
  }
}
