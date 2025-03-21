import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Player {
  final String idPlayer;
  final String strPlayer;
  final String strTeam;
  final String strNationality;
  final String strPosition;
  final String strDescriptionEN;
  final String strThumb;

  Player({
    required this.idPlayer,
    required this.strPlayer,
    required this.strTeam,
    required this.strNationality,
    required this.strPosition,
    required this.strDescriptionEN,
    required this.strThumb,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      idPlayer: json['idPlayer'] ?? '',
      strPlayer: json['strPlayer'] ?? '',
      strTeam: json['strTeam'] ?? '',
      strNationality: json['strNationality'] ?? '',
      strPosition: json['strPosition'] ?? '',
      strDescriptionEN: json['strDescriptionEN'] ?? '',
      strThumb: json['strThumb'] ?? '',
    );
  }
}

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
