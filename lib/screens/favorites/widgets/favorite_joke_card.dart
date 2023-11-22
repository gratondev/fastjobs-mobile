import 'package:fast_jobs/models/joke.dart';
import 'package:fast_jobs/widgets/card_button.dart';
import 'package:flutter/material.dart';

class FavoriteJokeCard extends StatelessWidget {
  const FavoriteJokeCard({
    Key? key,
    required this.joke,
    required this.onDelete,
  });

  final Joke joke;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Job ID: ${joke.id}',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 10),
                    Text(joke.value),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              CardButton(
                  onPressed: onDelete,
                  buttonColor: Colors.red,
                  buttonContentColor: Colors.white,
                  icon: Icons.delete)
            ],
          ),
        ),
      );
}
