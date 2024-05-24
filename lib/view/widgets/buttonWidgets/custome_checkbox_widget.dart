import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';

class CustomeCheckbox extends StatefulWidget {
  const CustomeCheckbox(
      {super.key,
      this.heigh,
      this.width,
      this.padding,
      this.borderWidth,
      this.borderRadius,
      this.iconSize,
      this.borderColor,
      this.fillColor,
      this.iconColor,
      this.child,
      this.isChacked,
      required this.onChange});
  final double? heigh;
  final double? width;
  final EdgeInsets? padding;
  final double? borderWidth;
  final double? borderRadius;
  final double? iconSize;
  final Color? borderColor;
  final Color? fillColor;
  final Color? iconColor;
  final Widget? child;
  final bool? isChacked;
  final Function(bool)? onChange;

  @override
  State<CustomeCheckbox> createState() => _CustomeCheckboxState();
}

class _CustomeCheckboxState extends State<CustomeCheckbox> {
  bool isChecked = false;
  @override
  void initState() {
    isChecked = widget.isChacked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          setState(() {
            isChecked = !isChecked;
          });
          widget.onChange?.call(isChecked);
        },
        child: Container(
          width: widget.heigh ?? 20,
          height: widget.width ?? 20,
          decoration: BoxDecoration(
              border: Border.all(
                  color: widget.borderColor ?? ColorConstant.inkWellTextColor,
                  width: widget.borderWidth ?? 2),
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius ?? 5)),
              color: isChecked
                  ? widget.fillColor ?? ColorConstant.inkWellTextColor
                  : null),
          child: isChecked
              ? widget.child ??
                  Icon(
                    Icons.check,
                    size: widget.iconSize ?? 16,
                    color: widget.iconColor ?? Colors.white,
                  )
              : null,
        ),
      ),
    );
  }
}
