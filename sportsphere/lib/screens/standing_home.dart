import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class StandingsScreen extends StatelessWidget {
  final List<Map<String, String>> leagues = [
    {"idLeague": "39", "strLeague": "Premier League"},
    {"idLeague": "4331", "strLeague": "La Liga"},
    {"idLeague": "4335", "strLeague": "Bundesliga"},
    {"idLeague": "4334", "strLeague": "Serie A"},
    {"idLeague": "4332", "strLeague": "Ligue 1"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Standings')),
      body: ListView.builder(
        itemCount: leagues.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(leagues[index]['strLeague']!),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LeagueStandingsScreen(
                      leagueId: leagues[index]['idLeague']!,
                      leagueName: leagues[index]['strLeague']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class LeagueStandingsScreen extends StatefulWidget {
  final String leagueId;
  final String leagueName;

  const LeagueStandingsScreen({
    super.key,
    required this.leagueId,
    required this.leagueName,
  });

  @override
  _LeagueStandingsScreenState createState() => _LeagueStandingsScreenState();
}

class _LeagueStandingsScreenState extends State<LeagueStandingsScreen> {
  List<dynamic> standings = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchStandings();
  }

  Future<void> fetchStandings() async {
    final String apiUrl =
        "https://v3.football.api-sports.io/standings?league=${widget.leagueId}&season=2022";
    const Map<String, String> headers = {
      "x-rapidapi-host": "v3.football.api-sports.io",
      "x-rapidapi-key": "a0ae70bf7c6687247992d15ddff92bfb"
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          standings = data['response'][0]['league']['standings'][0];
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load standings");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.leagueName} Standings')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(child: Text("Error loading standings"))
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 10,
                      headingRowHeight: 40,
                      dataRowHeight: 35,
                      columns: [
                        DataColumn(label: _adaptiveText("#", bold: true)),
                        DataColumn(label: _adaptiveText("Team", bold: true)),
                        DataColumn(label: _adaptiveText("Pts", bold: true)),
                        DataColumn(label: _adaptiveText("W", bold: true)),
                        DataColumn(label: _adaptiveText("D", bold: true)),
                        DataColumn(label: _adaptiveText("L", bold: true)),
                        DataColumn(label: _adaptiveText("GD", bold: true)),
                      ],
                      rows: standings.map((team) {
                        return DataRow(cells: [
                          DataCell(_adaptiveText(team['rank'].toString())),
                          DataCell(
                            Row(
                              children: [
                                Image.network(team['team']['logo'],
                                    width: 18, height: 18),
                                SizedBox(width: 4),
                                _adaptiveText(team['team']['name'],
                                    maxWidth: 85),
                              ],
                            ),
                          ),
                          DataCell(_adaptiveText(team['points'].toString())),
                          DataCell(
                              _adaptiveText(team['all']['win'].toString())),
                          DataCell(
                              _adaptiveText(team['all']['draw'].toString())),
                          DataCell(
                              _adaptiveText(team['all']['lose'].toString())),
                          DataCell(_adaptiveText(team['goalsDiff'].toString())),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
    );
  }

  Widget _adaptiveText(String text, {bool bold = false, double maxWidth = 50}) {
    return SizedBox(
      width: maxWidth,
      child: AutoSizeText(
        text,
        style: TextStyle(
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontSize: 12.0,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
