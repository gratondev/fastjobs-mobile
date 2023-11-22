import 'package:fast_jobs/bloc/favorites/favorites_bloc.dart';
import 'package:fast_jobs/models/joke.dart';
import 'package:fast_jobs/screens/favorites/widgets/favorite_joke_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key});

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  final Future<Box<Joke>> starredJokes = Hive.openBox('starred');

  @override
  Widget build(BuildContext context) {
    final loading = Center(
      child: Text(
        'Procurando...',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
    return FutureBuilder(
      future: starredJokes,
      builder: (context, snapshot) => snapshot.hasData
          ? BlocProvider<FavoritesBloc>(
              create: (_) => FavoritesBloc(
                snapshot.data!,
              )..add(FavoritesLoadEvent()),
              child: BlocConsumer<FavoritesBloc, FavoritesState>(
                  listener: (context, state) {
                    if (state is! FavoriteDeleteNotifyState) {
                      return;
                    }

                    ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Job cancelado'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    context.read<FavoritesBloc>().add(WidgetNotifiedEvent());
                  },
                  builder: (context, state) => state is ShowingFavoritesState
                      ? ListView.builder(
                          itemCount: context
                              .read<FavoritesBloc>()
                              .favoriteJokes
                              .length,
                          itemBuilder: (context, index) {
                            final joke = context
                                .read<FavoritesBloc>()
                                .favoriteJokes[index];
                            return FavoriteJokeCard(
                              joke: joke,
                              onDelete: () => context.read<FavoritesBloc>().add(
                                    FavoriteDeleteEvent(joke),
                                  ),
                            );
                          },
                        )
                      : loading),
            )
          : loading,
    );
  }
}
