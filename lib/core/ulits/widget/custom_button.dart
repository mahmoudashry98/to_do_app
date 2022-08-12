import 'package:flutter/material.dart';
import 'package:to_do_app/core/ulits/app_colors.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final double? height;
  final GestureTapCallback press;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.press,
    this.height,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: padding,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: CustomText(
            text: text,
            color: AppColors.textWhite,
          ),
        ),
      ),
    );
  }
}
