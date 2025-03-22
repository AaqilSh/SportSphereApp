class Player {
  final String idPlayer;
  final String strPlayer;
  final String strTeam;
  final String strNationality;
  final String strPosition;
  final String strDescriptionEN;
  final String strThumb;
  final String strCutout;
  final String dateBorn;
  Player({
    required this.idPlayer,
    required this.strPlayer,
    required this.strTeam,
    required this.strNationality,
    required this.strPosition,
    required this.strDescriptionEN,
    required this.strThumb,
    required this.strCutout,
    required this.dateBorn,
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
      strCutout: json['strCutout'] ?? '',
      dateBorn: json['dateBorn'] ?? '',
    );
  }
}
