import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sportsphere/screens/p_stat.dart';
import 'package:sportsphere/screens/player_screen.dart';

void main() {
  testWidgets('Tapping a player opens PlayerStatsScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: PlayersScreen()));

    // Wait for data to load
    await tester.pumpAndSettle();

    // Expand a team
    await tester.tap(find.byType(ExpansionTile).first);
    await tester.pumpAndSettle();

    // Tap on the first player
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();

    // Verify if PlayerStatsScreen is opened
    expect(find.byType(PlayerStatsScreen), findsOneWidget);
  });
}
