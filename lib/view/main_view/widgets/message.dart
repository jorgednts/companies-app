import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({
    required this.message,
    Key? key,
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) => Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
          child: Text(
            message,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
