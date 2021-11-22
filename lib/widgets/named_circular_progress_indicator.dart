import 'package:flutter/material.dart';

class NamedCircularProgressIndicator extends StatelessWidget {
  final text;

  const NamedCircularProgressIndicator(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [const CircularProgressIndicator(), Text('$text')],
    );
  }
}
