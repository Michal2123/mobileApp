import 'package:flutter/material.dart';

class MissingPetDetailInfoCardSection extends StatelessWidget {
  const MissingPetDetailInfoCardSection({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: child,
        ),
      ),
    );
  }
}
