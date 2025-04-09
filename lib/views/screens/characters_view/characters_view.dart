import 'package:flutter/material.dart';
import 'package:rickandmorty/views/widgets/character_cardview.dart';

class CharactersView extends StatelessWidget {
  const CharactersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Column(
            children: [
              _searchInputWidget(context),
              CharacterCardview(
                image:
                    'https://rickandmortyapi.com/api/character/avatar/88.jpeg',
                name: 'Rick Sanchez',
                origin: 'Eart - (C-137)',
                status: 'Yaşıyor',
                type: 'İnsan',
              ),
              CharacterCardview(
                image:
                    'https://rickandmortyapi.com/api/character/avatar/88.jpeg',
                name: 'Rick Sanchez',
                origin: 'Eart - (C-137)',
                status: 'Yaşıyor',
                type: 'İnsan',
              ),
              CharacterCardview(
                image:
                    'https://rickandmortyapi.com/api/character/avatar/88.jpeg',
                name: 'Rick Sanchez',
                origin: 'Eart - (C-137)',
                status: 'Yaşıyor',
                type: 'İnsan',
              ),
              CharacterCardview(
                image:
                    'https://rickandmortyapi.com/api/character/avatar/88.jpeg',
                name: 'Rick Sanchez',
                origin: 'Eart - (C-137)',
                status: 'Yaşıyor',
                type: 'İnsan',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _searchInputWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          labelText: 'Karakterlerde Ara',
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ),
      ),
    );
  }
}
