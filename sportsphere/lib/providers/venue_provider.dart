import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sportsphere/models/venue.dart';

class VenueProvider with ChangeNotifier {
  List<Venue> _venues = [];
  bool _isLoading = false;

  List<Venue> get venues => _venues;
  bool get isLoading => _isLoading;

  Future<void> searchVenues(String query) async {
    if (query.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        'https://www.thesportsdb.com/api/v1/json/3/searchvenues.php?t=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data['venues']);
      if (data['venues'] != null) {
        _venues = (data['venues'] as List)
            .map((venue) => Venue.fromJson(venue))
            .toList();
      } else {
        _venues = [];
      }
    } else {
      _venues = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
