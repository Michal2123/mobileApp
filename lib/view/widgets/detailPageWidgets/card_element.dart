import 'package:flutter/material.dart';

class CardElement extends StatelessWidget {
  const CardElement({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      elevation: 5,
      shadowColor: const Color.fromARGB(55, 0, 0, 0),
      child: child,
    );
  }
}
