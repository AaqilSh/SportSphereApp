import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Venue {
  final String idVenue;
  final String strVenue;
  final String strVenueAlternate;
  final String strSport;
  final String strDescriptionEN;
  final String strCountry;
  final String strLocation;
  final String intCapacity;
  final String strThumb;
  final String strFanart1;
  final String strFanart2;
  final String strFanart3;
  final String strFanart4;
  final String strWebsite;

  Venue({
    required this.idVenue,
    required this.strVenue,
    required this.strVenueAlternate,
    required this.strSport,
    required this.strDescriptionEN,
    required this.strCountry,
    required this.strLocation,
    required this.intCapacity,
    required this.strThumb,
    required this.strFanart1,
    required this.strFanart2,
    required this.strFanart3,
    required this.strFanart4,
    required this.strWebsite,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      idVenue: json['idVenue'] ?? '',
      strVenue: json['strVenue'] ?? '',
      strVenueAlternate: json['strVenueAlternate'] ?? '',
      strSport: json['strSport'] ?? '',
      strDescriptionEN: json['strDescriptionEN'] ?? '',
      strCountry: json['strCountry'] ?? '',
      strLocation: json['strLocation'] ?? '',
      intCapacity: json['intCapacity'] ?? '',
      strThumb: json['strThumb'] ?? '',
      strFanart1: json['strFanart1'] ?? '',
      strFanart2: json['strFanart2'] ?? '',
      strFanart3: json['strFanart3'] ?? '',
      strFanart4: json['strFanart4'] ?? '',
      strWebsite: json['strWebsite'] ?? '',
    );
  }
}

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
