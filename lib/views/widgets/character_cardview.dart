import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/app/locator.dart';
import 'package:rickandmorty/app/router.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/preferences_service.dart';
import 'package:rickandmorty/views/screens/favourites_view/favourites_viewmodel.dart';

class CharacterCardview extends StatefulWidget {
  final CharacterModel characterModel;
  final bool isFavorited;
  final ValueChanged<bool> onFavoriteChanged;

  const CharacterCardview({
    super.key,
    required this.characterModel,
    this.isFavorited = false,
    required this.onFavoriteChanged,
  });

  @override
  State<CharacterCardview> createState() => _CharacterCardviewState();
}

class _CharacterCardviewState extends State<CharacterCardview> {
  late bool isFavorited;

  @override
  void initState() {
    isFavorited = widget.isFavorited;
    super.initState();
  }

  void _favoriteCharacters() {
    if (isFavorited) {
      locator<PreferencesService>().removeCharacter(widget.characterModel.id);
      isFavorited = false;
    } else {
      locator<PreferencesService>().saveCharacter(widget.characterModel.id);
      isFavorited = true;
    }

    widget.onFavoriteChanged(
      isFavorited,
    ); // Favori durumunu üst widget'a bildir

    try {
      context
          .read<FavouritesViewmodel>()
          .getFavorites(); // Favoriler sayfasındaki favorileri yeniden al
    } catch (e) {
      // Hata durumunda herhangi bir şey yapma
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => context.push(
            AppRoutes.characterDetail,
            extra: widget.characterModel,
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Hero(
                      tag: widget.characterModel.image,
                      child: Image.network(
                        widget.characterModel.image,
                        height: 100,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 17,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.characterModel.name,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(height: 5),
                          _infoWidget(
                            type: "Köken",
                            value: widget.characterModel.origin.name,
                          ),
                          SizedBox(height: 4),
                          _infoWidget(
                            type: "Durum",
                            value:
                                "${widget.characterModel.status} - ${widget.characterModel.species}",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: _favoriteCharacters,
              icon: Icon(isFavorited ? Icons.bookmark : Icons.bookmark_border),
            ),
          ],
        ),
      ),
    );
  }

  Column _infoWidget({required String type, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(type, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300)),
        Text(
          value,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
