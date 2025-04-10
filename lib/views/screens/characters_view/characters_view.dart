import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/views/screens/characters_view/characters_viewmodel.dart';
import 'package:rickandmorty/views/widgets/character_cardview.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  void initState() {
    super.initState();
    context.read<CharactersViewmodel>().getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Column(
            children: [
              _searchInputWidget(context),
              Consumer<CharactersViewmodel>(
                builder: (context, viewModel, child) {
                  if (viewModel.charactersModel == null) {
                    return CircularProgressIndicator.adaptive();
                  } else {
                    return Flexible(
                      child: ListView.builder(
                        itemCount: viewModel.charactersModel!.characters.length,
                        itemBuilder: (context, index) {
                          final characterModel =
                              viewModel.charactersModel!.characters[index];
                          return CharacterCardview(
                            characterModel: characterModel,
                          );
                        },
                      ),
                    );
                  }
                },
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
