import 'package:flutter/material.dart';

/// widget to replace [AppBar] for a custom look
class StatusBar extends StatelessWidget {
  /// construcutor
  const StatusBar({
    Key? key,
    this.color = Colors.blue,
  }) : super(key: key);

  /// background color of the status bar
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: MediaQuery.of(context).viewPadding.top,
    );
  }
}
