import 'dart:async';

import 'package:fast_jobs/models/joke.dart';
import 'package:fast_jobs/services/api_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:url_launcher/url_launcher_string.dart';

part 'jokes_event.dart';

part 'jokes_state.dart';

class JokesBloc extends Bloc<JokesEvent, JokesState> {
  JokesBloc(
    this.jokeService,
    this.starredJokesBox,
  ) : super(JokesStateInitial()) {
    on<JokeLoadEvent>(
      (event, emit) async {
        final Joke joke;
        try {
          joke = await jokeService.getRandomJoke();
          emit(
            JokeLoadedState(
              joke: joke,
              isStarred: starredJokesBox.containsKey(joke.id),
            ),
          );
        } on JokeServiceException {
          if (state is! NetworkErrorState) {
            emit(NetworkErrorState());
          }
          Future.delayed(
            const Duration(seconds: 1),
            () => add(JokeLoadEvent()),
          );
        }
      },
    );

    on<JokeStarEvent>(
      (event, emit) async {
        if (event.isStarred) {
          await starredJokesBox.delete(event.joke.id);
        } else {
          await starredJokesBox.put(event.joke.id, event.joke);
        }
        emit(JokeStarredState(event.joke, !event.isStarred));
      },
    );

    on<JokeCopyEvent>(
      (event, emit) async {
        await Clipboard.setData(
          ClipboardData(text: event.text),
        );
        emit(JokeCopiedState());
      },
    );

    on<JokeOpenBrowserEvent>(
      (event, emit) async {
        if (event.url == null) {
          emit(BrowserOpenErrorState());
        }

        unawaited(
          launchUrlString(
            event.url!,
            mode: LaunchMode.externalApplication,
          ),
        );
      },
    );

    on<WidgetNotifiedEvent>(
      (event, emit) async {
        emit(ShowingJokesState());
      },
    );
  }

  final JokeService jokeService;
  final Box<Joke> starredJokesBox;
}
