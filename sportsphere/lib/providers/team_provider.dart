import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sportsphere/models/team.dart';

class TeamProvider with ChangeNotifier {
  List<Team> _teams = [];
  bool _isLoading = false;

  List<Team> get teams => _teams;
  bool get isLoading => _isLoading;

  Future<void> searchTeams(String query) async {
    if (query.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        'https://www.thesportsdb.com/api/v1/json/3/searchteams.php?t=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(response.body);
      if (data['teams'] != null) {
        _teams =
            (data['teams'] as List).map((team) => Team.fromJson(team)).toList();
      } else {
        _teams = [];
      }
    } else {
      _teams = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
