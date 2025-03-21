import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';

class StandingsPage extends StatefulWidget {
  @override
  _StandingsPageState createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  List<dynamic> standings = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchStandings();
  }

  Future<void> fetchStandings() async {
    const String apiUrl =
        "https://v3.football.api-sports.io/standings?league=39&season=2022";
    const Map<String, String> headers = {
      "x-rapidapi-host": "v3.football.api-sports.io",
      "x-rapidapi-key": "a0ae70bf7c6687247992d15ddff92bfb"
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(response.body);
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
      appBar: AppBar(title: Text("Premier League Standings")),
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
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
        // maxLines: 1,
        // minFontSize: 10, // Ensures it's still readable when scaled down
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
