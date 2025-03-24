import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sportsphere/screens/player_screen.dart';

void main() {
  testWidgets('Teams and players load correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: PlayersScreen()));

    // Wait for data to load
    await tester.pumpAndSettle();

    // Check if at least one team is displayed
    expect(find.byType(ExpansionTile), findsWidgets);

    // Expand the first team
    await tester.tap(find.byType(ExpansionTile).first);
    await tester.pumpAndSettle();

    // Check if at least one player is displayed
    expect(find.byType(ListTile), findsWidgets);
  });
}
