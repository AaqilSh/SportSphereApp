import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sportsphere/screens/player_screen.dart';

void main() {
  testWidgets('Favorite player toggle test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: PlayersScreen()));

    // Wait for data to load
    await tester.pumpAndSettle();

    // Expand the first team
    await tester.tap(find.byType(ExpansionTile).first);
    await tester.pumpAndSettle();

    // Find the first favorite button and tap it
    final favoriteButton = find.byIcon(Icons.favorite_border).first;
    await tester.tap(favoriteButton);
    await tester.pumpAndSettle();

    // Check if the icon changed to filled heart
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // Tap again to remove favorite
    await tester.tap(find.byIcon(Icons.favorite).first);
    await tester.pumpAndSettle();

    // Check if the icon reverted
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });
}
