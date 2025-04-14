import 'package:dio/dio.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/models/episode_model.dart';

class ApiService {
  final _dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'));

  Future<CharactersModel> getCharacters({
    String? url,
    Map<String, dynamic>? args,
  }) async {
    try {
      final response = await _dio.get(
        url ?? '/character',
        queryParameters: args,
      );
      return CharactersModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CharacterModel>> getMultipleCharacters(List<int> idList) async {
    try {
      if (idList.isEmpty) {
        return [];
      }
      final response = await _dio.get('/character/${idList.join(',')}');
      // Eğer response.data bir List ise
      if (response.data is List) {
        return (response.data as List)
            .map((e) => CharacterModel.fromJson(e))
            .toList();
      }
      // Eğer response.data bir Map ise (tek bir karakter verisi)
      else if (response.data is Map) {
        var character = response.data;
        return [CharacterModel.fromJson(character)];
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EpisodeModel>> getMultipleEpisode(List<String> list) async {
    try {
      final List<String> episodeNumbers =
          list.map((e) => e.split('/').last).toList();

      String episodes = episodeNumbers.join(',');
      if (list.length == 1) {
        episodes = '$episodes,';
      }

      final response = await _dio.get('/episode/$episodes');
      return (response.data as List)
          .map((e) => EpisodeModel.fromMap(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
