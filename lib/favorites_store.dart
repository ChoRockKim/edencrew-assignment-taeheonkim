import 'package:flutter/foundation.dart';

class FavoritesStore extends ChangeNotifier {
  final Set<String> _ids = <String>{};

  bool isFavorite(String id) => _ids.contains(id);

  void toggle(String id) {
    if (_ids.contains(id)) {
      _ids.remove(id);
    } else {
      _ids.add(id);
    }
    notifyListeners();
  }
}
