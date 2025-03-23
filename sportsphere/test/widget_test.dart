import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sportsphere/screens/standing_home.dart';

void main() {
  testWidgets('StandingsScreen should display league names',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: StandingsAndStatsScreen()));

    expect(find.text('Premier League'), findsOneWidget);
    expect(find.text('La Liga'), findsOneWidget);
    expect(find.text('Bundesliga'), findsOneWidget);
    expect(find.text('Serie A'), findsOneWidget);
    expect(find.text('Ligue 1'), findsOneWidget);
  });

  testWidgets('Tapping a league navigates to LeagueStandingsScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: StandingsAndStatsScreen()));

    await tester.tap(find.text('Premier League'));
    await tester.pumpAndSettle();

    expect(find.text('Premier League Standings'), findsOneWidget);
  });
}
