import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportsphere/providers/font_size_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Default font size should be 16.0', () {
    final fontSizeProvider = FontSizeProvider();
    expect(fontSizeProvider.fontSize, 16.0);
  });

  test('Set and get font size', () async {
    SharedPreferences.setMockInitialValues({});
    final fontSizeProvider = FontSizeProvider();

    // await fontSizeProvider.setFontSize(20.0);
    expect(fontSizeProvider.fontSize, 20.0);
  });

  test('Load font size from shared preferences', () async {
    SharedPreferences.setMockInitialValues({'fontSize': 18.0});
    final fontSizeProvider = FontSizeProvider();
    await fontSizeProvider.loadFontSize();
    expect(fontSizeProvider.fontSize, 18.0);
  });
}
