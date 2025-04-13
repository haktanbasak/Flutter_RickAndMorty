import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final SharedPreferences prefs;

  PreferencesService({required this.prefs});

  final String _characterKey = 'character_key';

  void storeCharacters(List<String> characters) async {
    await prefs.setStringList(_characterKey, characters);
  }

  void saveCharacter(int id) async {
    final chactersList = prefs.getStringList(_characterKey) ?? [];
    chactersList.add(id.toString());
    storeCharacters(chactersList);
  }

  void removeCharacter(int id) async {
    final chactersList = prefs.getStringList(_characterKey) ?? [];
    chactersList.remove(id.toString());
    storeCharacters(chactersList);
  }

  List<int> getSavedCharacters() {
    final chactersList = prefs.getStringList(_characterKey) ?? [];
    return chactersList.map((e) => int.parse(e)).toList();
  }
}
