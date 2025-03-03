import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  String? _userEmail;
  bool _isAuthenticated = false;

  String? get userEmail => _userEmail;
  bool get isAuthenticated => _isAuthenticated;

  void login(String email, String password) {
    // Simulating authentication (Replace with actual authentication logic)
    if (email == "test@example.com" && password == "password123") {
      _userEmail = email;
      _isAuthenticated = true;
      notifyListeners();
    } else {
      throw Exception("Invalid email or password");
    }
  }

  void logout() {
    _userEmail = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
