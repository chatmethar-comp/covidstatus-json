import 'package:flutter/material.dart';

class BoxStatus extends StatelessWidget {
  const BoxStatus({
    Key? key,
    required this.data,
    required this.head,
  }) : super(key: key);

  final TextEditingController data;
  final String head;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          head,
          style: _style,
        ),
        Text(
          data.text,
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

TextStyle _style = const TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);
