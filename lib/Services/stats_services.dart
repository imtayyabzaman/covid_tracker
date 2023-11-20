import 'dart:convert';

import 'package:covid_tracker/Models/world_stats_model.dart';
import 'package:covid_tracker/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatsModel> fetchWorldStatesRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
}
