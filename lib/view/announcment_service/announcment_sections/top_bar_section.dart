import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class AnnouncmentTopBarSection extends StatefulWidget {
  const AnnouncmentTopBarSection({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<AnnouncmentTopBarSection> createState() =>
      _AnnouncmentTopBarSectionState();
}

class _AnnouncmentTopBarSectionState extends State<AnnouncmentTopBarSection> {
  bool _isShow = true;

  @override
  void initState() {
    widget.scrollController.addListener(onScrollHandler);
    super.initState();
  }

  void onScrollHandler() {
    final direction = widget.scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      setState(() {
        _isShow = true;
      });
    } else if (direction == ScrollDirection.reverse) {
      setState(() {
        _isShow = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transformAlignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
      height: _isShow ? 50 : 0,
      child: const Align(
        alignment: Alignment.center,
        child: InputLabelText(text: 'Usługi'),
      ),
    );
  }
}
