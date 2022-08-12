import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size, heigtText;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final bool underline;

  const CustomText({
    Key? key,
    required this.text,
    this.color,
    this.size = 18,
    this.maxLines,
    this.textOverflow,
    this.fontWeight,
    this.heigtText,
    this.textAlign,
    this.underline = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        overflow: textOverflow,
        maxLines: maxLines,
        textAlign: textAlign,
        style: TextStyle(
          decoration: (!underline) ? null : TextDecoration.underline,
         color: color,
          fontSize: size,
          fontWeight: fontWeight,
          height: heigtText,
          fontFamily: 'Almarai',
        ),
    );
  }
}

