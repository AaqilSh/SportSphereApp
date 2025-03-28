import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportsphere/providers/player_provider.dart';
import 'package:sportsphere/providers/team_provider.dart';
import 'package:sportsphere/providers/venue_provider.dart';
import 'package:sportsphere/screens/player_detail.dart';
import 'package:sportsphere/screens/team_detail_screen.dart';
import 'package:sportsphere/screens/venue_detials_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Teams, Players & Venues',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                context.read<TeamProvider>().searchTeams(query);
                context.read<PlayerProvider>().searchPlayers(query);
                context.read<VenueProvider>().searchVenues(query);
              },
            ),
          ),
          Expanded(
            child: Consumer3<TeamProvider, PlayerProvider, VenueProvider>(
              builder: (context, teamProvider, playerProvider, venueProvider,
                  child) {
                if (teamProvider.isLoading &&
                    playerProvider.isLoading &&
                    venueProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (teamProvider.teams.isEmpty &&
                    playerProvider.players.isEmpty &&
                    venueProvider.venues.isEmpty) {
                  return Center(child: Text('No results found'));
                }

                return ListView(
                  children: [
                    if (teamProvider.teams.isNotEmpty)
                      _buildSection(
                        title: 'Teams',
                        itemCount: teamProvider.teams.length,
                        itemBuilder: (context, index) {
                          final team = teamProvider.teams[index];
                          return _buildListItem(
                            title: team.strTeam,
                            subtitle: team.strLeague
                                    .replaceFirst(RegExp(r'^_-'), '') ??
                                '',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TeamDetailsScreen(team: team),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (playerProvider.players.isNotEmpty)
                      _buildSection(
                        title: 'Players',
                        itemCount: playerProvider.players.length,
                        itemBuilder: (context, index) {
                          final player = playerProvider.players[index];
                          return _buildListItem(
                              title: player.strPlayer,
                              subtitle:
                                  '${player.strTeam} - ${player.strPosition}'
                                      .replaceFirst(RegExp(r'^_'), ''),
                              imageUrl: player.strThumb?.isNotEmpty == true
                                  ? player.strThumb
                                  : null,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PlayerDetailsScreen(
                                                player: player)));
                              });
                        },
                      ),
                    if (venueProvider.venues.isNotEmpty)
                      _buildSection(
                        title: 'Venues',
                        itemCount: venueProvider.venues.length,
                        itemBuilder: (context, index) {
                          final venue = venueProvider.venues[index];
                          return _buildListItem(
                            title: venue.strVenue,
                            subtitle:
                                '${venue.strLocation} - Capacity: ${venue.intCapacity}'
                                    .replaceFirst(RegExp(r'^_'), ''),
                            imageUrl: venue.strThumb.isNotEmpty == true
                                ? venue.strThumb
                                : null,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      VenueDetailsScreen(venue: venue),
                                ),
                              );
                            },
                          );
                        },
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        ),
      ],
    );
  }

  Widget _buildListItem({
    required String title,
    required String subtitle,
    String? imageUrl,
    VoidCallback? onTap,
  }) {
    return Card(
      color: Color(0xffDAF0F2),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: imageUrl != null
            ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
            : null,
        onTap: onTap,
      ),
    );
  }
}
