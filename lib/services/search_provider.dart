import 'package:flutter/material.dart';
import 'package:shoopy/model/usersc_model.dart';

class UserProvider extends ChangeNotifier {
  bool _showSearchBar = false;
  late TextEditingController _searchController;

  final List<Userr> _usersList = [
    Userr(name: "John Doe", email: "john@example.com", isOnline: true),
    Userr(name: "Jane Smith", email: "jane@example.com", isOnline: false),
    Userr(name: "Harry Kane", email: "harry@example.com", isOnline: false),
    Userr(name: "Steve Smith", email: "steve@example.com", isOnline: true),
  ];

  UserProvider() {
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  void toggleSearchBar() {
    _showSearchBar = !_showSearchBar;
    if (_showSearchBar == false) {
      _searchController.clear();
    }
    notifyListeners();
  }

  List<Userr> get usersList => _usersList;

  List<Userr> get filteredUsers {
    final query = _searchController.text.toLowerCase();
    return query.isEmpty
        ? _usersList
        : _usersList
        .where((user) =>
    user.name.toLowerCase().contains(query) ||
        user.email.toLowerCase().contains(query))
        .toList();
  }

  void _onSearchChanged() {
    notifyListeners();
  }

  bool get showSearchBar => _showSearchBar;

  TextEditingController get searchController => _searchController;
}
