import 'package:flutter/material.dart';
import 'package:rickandmorty/app/locator.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/preferences_service.dart';

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

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  child: Image.network(
                    widget.characterModel.image,
                    height: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 17,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.characterModel.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
              ],
            ),
          ),
          IconButton(
            onPressed: _favoriteCharacters,
            icon: Icon(isFavorited ? Icons.bookmark : Icons.bookmark_border),
          ),
        ],
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
