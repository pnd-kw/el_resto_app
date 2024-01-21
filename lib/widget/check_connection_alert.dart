import 'package:flutter/material.dart';

class CheckConnectionAlert extends StatelessWidget {
  final void Function()? onPressed;
  const CheckConnectionAlert({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'No Internet Connection',
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
        textAlign: TextAlign.center,
      ),
      content: Text(
        'Please check your internet connection',
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
        textAlign: TextAlign.center,
      ),
      actions: [
        Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: onPressed,
            child: Text(
              'Close',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ],
    );
  }
}
