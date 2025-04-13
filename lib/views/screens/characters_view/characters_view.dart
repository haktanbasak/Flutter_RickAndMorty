import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/views/screens/characters_view/characters_viewmodel.dart';
import 'package:rickandmorty/views/widgets/character_card_listview.dart';

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
    final viewModel = context.watch<CharactersViewmodel>();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Column(
            children: [
              _searchInputWidget(context, viewModel: viewModel),
              viewModel.charactersModel == null
                  ? CircularProgressIndicator.adaptive()
                  : CharacterCardListview(
                    characters: viewModel.charactersModel!.characters,
                    onLoadMore: viewModel.getCharactersMore,
                    loadMore: viewModel.loadMore,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _searchInputWidget(
    BuildContext context, {
    required CharactersViewmodel viewModel,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) {
          viewModel.getCharactersByName(value);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          hintText: 'Karakterlerde Ara',
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ),
      ),
    );
  }
}
