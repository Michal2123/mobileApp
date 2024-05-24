import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/inkwell_text_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class SettingsPageDistanceSection extends StatefulWidget {
  const SettingsPageDistanceSection({super.key});

  @override
  State<SettingsPageDistanceSection> createState() =>
      _SettingsPageDistanceSectionState();
}

class _SettingsPageDistanceSectionState
    extends State<SettingsPageDistanceSection> {
  double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 35),
            child: GestureDetector(
              onTap: () {},
              child: const InkWellText(text: 'Zapisz', weight: FontWeight.w600),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: InputLabelText(text: 'Odległość'),
          ),
        ),
        Slider(
          activeColor: ColorConstant.inkWellTextColor,
          value: _currentSliderValue,
          max: 100,
          min: 1,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
        Align(
            alignment: Alignment.centerRight,
            child: LabelText(text: '${_currentSliderValue.round()} km'))
      ],
    );
  }
}
