import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sportsphere/models/player.dart';

class PlayerProvider with ChangeNotifier {
  List<Player> _players = [];
  bool _isLoading = false;

  List<Player> get players => _players;
  bool get isLoading => _isLoading;

  Future<void> searchPlayers(String query) async {
    if (query.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        'https://www.thesportsdb.com/api/v1/json/3/searchplayers.php?p=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(response.body);
      if (data['player'] != null) {
        _players = (data['player'] as List)
            .map((player) => Player.fromJson(player))
            .toList();
      } else {
        _players = [];
      }
    } else {
      _players = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
