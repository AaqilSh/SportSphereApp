class Team {
  final String idTeam;
  final String strTeam;
  final String strLeague;
  final String strLeague2;
  final String strLeague3;
  final String strLeague4;
  final String strStadium;
  final String strKeywords;
  final String strWebsite;
  final String strDescriptionEN;
  final String strTeamBadge;

  Team({
    required this.idTeam,
    required this.strTeam,
    required this.strLeague,
    required this.strLeague2,
    required this.strLeague3,
    required this.strLeague4,
    required this.strStadium,
    required this.strKeywords,
    required this.strWebsite,
    required this.strDescriptionEN,
    required this.strTeamBadge,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      idTeam: json['idTeam'] ?? '',
      strTeam: json['strTeam'] ?? '',
      strLeague: json['strLeague'] ?? '',
      strLeague2: json['strLeague2'] ?? '',
      strLeague3: json['strLeague3'] ?? '',
      strLeague4: json['strLeague4'] ?? '',
      strStadium: json['strStadium'] ?? '',
      strKeywords: json['strKeywords'] ?? '',
      strWebsite: json['strWebsite'] ?? '',
      strDescriptionEN: json['strDescriptionEN'] ?? '',
      strTeamBadge: json['strTeamBadge'] ?? '',
    );
  }
}
