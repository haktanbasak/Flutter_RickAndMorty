import 'package:flutter/material.dart';
import 'package:rickandmorty/app/locator.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/api_service.dart';

enum CharacterStatus { all, alive, dead, unknown }

class CharactersViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  CharacterStatus characterStatus = CharacterStatus.all;

  CharactersModel? _charactersModel;
  CharactersModel? get charactersModel => _charactersModel;

  void clearCharacters() {
    _charactersModel = null;
    currentPageIndex = 1;
    notifyListeners();
  }

  void getCharacters() async {
    _charactersModel = await _apiService.getCharacters();
    notifyListeners();
  }

  bool loadMore = false;
  int currentPageIndex = 1;

  void setLoadMore(bool value) {
    loadMore = value;
    notifyListeners();
  }

  void getCharactersMore() async {
    // zaten yükleniyorsa tekrar istek atma
    if (loadMore) return;

    // eğer son sayfadaysak tekrar istek atma
    if (currentPageIndex == _charactersModel!.info.pages) return;

    setLoadMore(true);
    final data = await _apiService.getCharacters(
      url: _charactersModel?.info.next,
    );
    setLoadMore(false);

    currentPageIndex++;

    _charactersModel!.info = data.info;
    _charactersModel!.characters.addAll(data.characters);
    notifyListeners();
  }

  void getCharactersByName(String name) async {
    clearCharacters();
    _charactersModel = await _apiService.getCharacters(args: {'name': name});
    notifyListeners();
  }

  void onCharacterStatusChanged(CharacterStatus status) async {
    characterStatus = status;
    clearCharacters();

    Map<String, dynamic> args = {};

    if (status != CharacterStatus.all) {
      args = {'status': status.name};
    }

    _charactersModel = await _apiService.getCharacters(args: args);
    notifyListeners();
  }
}
