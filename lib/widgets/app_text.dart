import 'package:flutter/material.dart';


import '../../utils/app_colors.dart';

class AppText extends StatelessWidget {
  final String? text;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final Color? color;
  final double size;
  final FontWeight? fontWeight;
  final TextAlign textAlign;
  final TextStyle? style;

   AppText(this.text,
      {this.style, this.textAlign = TextAlign.left,
       this.fontWeight,
       this.color= Colors.black,
       this.textOverflow,
       this.size = 16,
       // this.text = '',
       this.maxLines,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      style: style ??
          TextStyle(
              fontSize: size,
              fontFamily: 'Pretendard',
              color: color,
              fontWeight: fontWeight,
              height: 1.2),
    );
  }
}
