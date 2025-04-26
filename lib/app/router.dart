import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/models/location_model.dart';
import 'package:rickandmorty/views/app_view.dart';
import 'package:rickandmorty/views/screens/character_profile_view/character_profile_view.dart';
import 'package:rickandmorty/views/screens/character_profile_view/character_profile_viewmodel.dart';
import 'package:rickandmorty/views/screens/characters_view/characters_view.dart';
import 'package:rickandmorty/views/screens/characters_view/characters_viewmodel.dart';
import 'package:rickandmorty/views/screens/favourites_view/favourites_view.dart';
import 'package:rickandmorty/views/screens/favourites_view/favourites_viewmodel.dart';
import 'package:rickandmorty/views/screens/locations_view/location_viewmodel.dart';
import 'package:rickandmorty/views/screens/locations_view/locations_view.dart';
import 'package:rickandmorty/views/screens/residents_view/resident_view.dart';
import 'package:rickandmorty/views/screens/residents_view/resident_viewmodel.dart';
import 'package:rickandmorty/views/screens/sections_view/sections_view.dart';
import 'package:rickandmorty/views/screens/sections_view/sections_viewmodel.dart';

final _routerKey = GlobalKey<NavigatorState>();

class AppRoutes {
  AppRoutes._();

  static const String characters = '/';
  static const String favourites = '/favourites';
  static const String locations = '/locations';
  static const String sections = '/sections';
  static const String characterDetail = '/characterDetail';

  static const String residentsRoute = 'residents';
  static const String residents = '/locations/residents';
}

final router = GoRouter(
  navigatorKey: _routerKey,
  initialLocation: AppRoutes.characters,
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navigationShell) =>
              AppView(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.characters,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => CharactersViewmodel(),
                    child: CharactersView(),
                  ),
              routes: [
                GoRoute(
                  path: AppRoutes.characterDetail,
                  builder:
                      (context, state) => ChangeNotifierProvider(
                        create: (context) => CharacterProfileViewmodel(),
                        child: CharacterProfileView(
                          characterModel: state.extra as CharacterModel,
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.favourites,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => FavouritesViewmodel(),
                    child: FavouritesView(),
                  ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.locations,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => LocationViewmodel(),
                    child: LocationsView(),
                  ),
              routes: [
                GoRoute(
                  path: AppRoutes.residentsRoute,
                  builder:
                      (context, state) => ChangeNotifierProvider(
                        create: (context) => ResidentViewmodel(),
                        child: ResidentView(
                          locationItem: state.extra as LocationItem,
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.sections,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => SectionsViewmodel(),
                    child: SectionsView(),
                  ),
            ),
          ],
        ),
      ],
    ),
  ],
);
