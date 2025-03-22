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
