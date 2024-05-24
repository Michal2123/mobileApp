import 'package:flutter/material.dart';

class AnimatedCollapse extends StatefulWidget {
  final Widget child;
  final bool expand;
  const AnimatedCollapse({super.key, this.expand = false, required this.child});

  @override
  State<AnimatedCollapse> createState() => _AnimatedCollapseState();
}

class _AnimatedCollapseState extends State<AnimatedCollapse>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _collapsController;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _collapseCheck();
  }

  ///Setting up the _animation
  void prepareAnimations() {
    _collapsController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = CurvedAnimation(
      parent: _collapsController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _collapseCheck() {
    if (widget.expand) {
      _collapsController.forward();
      return;
    }
    _collapsController.reverse();
  }

  @override
  void didUpdateWidget(AnimatedCollapse oldWidget) {
    super.didUpdateWidget(oldWidget);
    _collapseCheck();
  }

  @override
  void dispose() {
    _collapsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: _animation, child: widget.child);
  }
}
