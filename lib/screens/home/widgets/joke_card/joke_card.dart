import 'dart:math' as math;

import 'package:fast_jobs/bloc/jokes/jokes_bloc.dart';
import 'package:fast_jobs/models/joke.dart';
import 'package:fast_jobs/screens/home/widgets/joke_card/joke_card_image.dart';
import 'package:fast_jobs/widgets/card_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// This widget is made stateful to keep the card color and starred state.
class JokeCard extends StatefulWidget {
  const JokeCard({
    required Key? key,
    required this.joke,
    required this.isStarred,
    required this.onDismissed,
  });

  final Joke joke;
  final bool isStarred;
  final VoidCallback onDismissed;

  JokeCard starred({required bool isStarred}) => JokeCard(
        key: UniqueKey(),
        joke: joke,
        isStarred: isStarred,
        onDismissed: onDismissed,
      );

  @override
  State<StatefulWidget> createState() => JokeCardState();
}

class JokeCardState extends State<JokeCard> {
  late Color cardColor;
  late Color buttonContentColor;
  late bool isStarred;

  @override
  void initState() {
    super.initState();
    cardColor =
        Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
    buttonContentColor =
        cardColor == Colors.yellow ? Colors.black : Colors.white;
    isStarred = widget.isStarred;
  }

  @override
  Widget build(BuildContext context) {
    var card = Card(
        margin: EdgeInsets.only(top: 150, left: 20, right: 20, bottom: 20),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                JokeCardImage(
                  bgColor: cardColor,
                  image: const Image(
                    image: AssetImage('./assets/fast_icon.png'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Job ID: ${widget.joke.id}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(widget.joke.value),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 0)),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (widget.joke.url != null)
                                CardButton(
                                  buttonColor: Colors.green,
                                  buttonContentColor: buttonContentColor,
                                  icon: Icons.check,
                                  onPressed: () => context
                                      .read<JokesBloc>()
                                      .add(
                                        JokeStarEvent(widget.joke, isStarred),
                                      ),
                                ),
                              CardButton(
                                  buttonColor: Colors.red,
                                  buttonContentColor: buttonContentColor,
                                  icon: Icons.cancel,
                                  onPressed: () {
                                    widget.onDismissed();
                                  }),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 0)),
                        const Text('👈 Arraste para ver novos Jobs 👉'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));

    return BlocListener<JokesBloc, JokesState>(
      listener: (context, state) {
        // Listen for starred state update
        if (state is! JokeStarredState || state.joke != widget.joke) {
          return;
        }
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(
                state.isStarred
                    ? 'Job aceito, disponível em Meus Jobs!'
                    : 'Job cancelado',
              ),
              duration: const Duration(seconds: 1),
            ),
          );

        setState(() => isStarred = state.isStarred);
        context.read<JokesBloc>().add(WidgetNotifiedEvent());
      },
      // Stretch the card and add Dismissible for swipe gestures
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Dismissible(
          key: ObjectKey(card),
          onDismissed: (_) => widget.onDismissed(),
          dismissThresholds: const {DismissDirection.horizontal: 0.2},
          child: card,
        ),
      ),
    );
  }
}
