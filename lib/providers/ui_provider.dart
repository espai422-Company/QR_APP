import 'package:flutter/material.dart';

/// ChangeNotifier class for managing the UI state.
class UiProvider extends ChangeNotifier {
  /// Variable to store the selected menu option.
  int _selectedMenuOpt = 0;

  /// Getter for retrieving the selected menu option.
  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  /// Setter for updating the selected menu option and notifying listeners.
  set selectedMenuOpt(int i) {
    this._selectedMenuOpt = i;
    notifyListeners();
  }
}
