import 'dart:convert';

class Favorites {
  final List<String> ids;

  Favorites({required this.ids});

  static String toJson(Favorites favorites) {
    return jsonEncode({
      'ids': favorites.ids,
    });
  }

  static Favorites fromJson(String jsonString) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return Favorites(
      ids: List<String>.from(jsonMap['ids']),
    );
  }
}
