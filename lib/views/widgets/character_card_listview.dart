import 'package:flutter/material.dart';
import 'package:rickandmorty/app/locator.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/preferences_service.dart';
import 'package:rickandmorty/views/widgets/character_cardview.dart';

class CharacterCardListview extends StatefulWidget {
  final List<CharacterModel> characters;
  final VoidCallback? onLoadMore;
  final bool loadMore;
  const CharacterCardListview({
    super.key,
    required this.characters,
    this.onLoadMore,
    this.loadMore = false,
  });

  @override
  State<CharacterCardListview> createState() => _CharacterCardListviewState();
}

class _CharacterCardListviewState extends State<CharacterCardListview> {
  final _scrollController = ScrollController();
  bool _isLoading = true;
  List<int> _favoritedList = [];

  @override
  void initState() {
    _getFavorites();
    _detectScrollBottom();
    super.initState();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    setState(() {});
  }

  void _getFavorites() async {
    _favoritedList = locator<PreferencesService>().getSavedCharacters();
    _setLoading(false);
    setState(() {});
  }

  void _detectScrollBottom() {
    if (widget.onLoadMore != null) {
      _scrollController.addListener(() {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentPosition = _scrollController.position.pixels;
        const int delta = 200;

        if (maxScroll - currentPosition <= delta) {
          widget.onLoadMore!();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return CircularProgressIndicator.adaptive();
    }
    return Flexible(
      child: ListView.builder(
        itemCount: widget.characters.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          final characterModel = widget.characters[index];
          final bool isFavorited = _favoritedList.contains(characterModel.id);
          return Column(
            children: [
              CharacterCardview(
                characterModel: characterModel,
                isFavorited: isFavorited,
                onFavoriteChanged: (bool newValue) {
                  setState(() {
                    if (newValue) {
                      _favoritedList.add(characterModel.id);
                    } else {
                      _favoritedList.remove(characterModel.id);
                    }
                  });
                },
              ),
              if (widget.loadMore && index == widget.characters.length - 1)
                CircularProgressIndicator.adaptive(),
            ],
          );
        },
      ),
    );
  }
}
