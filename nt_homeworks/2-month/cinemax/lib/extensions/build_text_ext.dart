import 'package:flutter/material.dart';

extension BuildTextExt on String {
  Text buildText({
    double? fontSize,
    Color? color,
    String? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    String? fontFamily,
    double? letterSpacing,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? decoration,
  }) {
    return Text(
      this,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 14,
        color: color ?? Colors.black,
        fontWeight: _parseFontWeight(fontWeight) ?? FontWeight.normal,
        fontFamily: fontFamily ?? "Kufam",
        letterSpacing: letterSpacing,
        height: height,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  /// String qiymatdan FontWeight parse qiluvchi yordamchi metod
  FontWeight? _parseFontWeight(String? weight) {
    switch (weight) {
      case 'w100':
        return FontWeight.w100;
      case 'w200':
        return FontWeight.w200;
      case 'w300':
        return FontWeight.w300;
      case 'w400':
        return FontWeight.w400;
      case 'w500':
        return FontWeight.w500;
      case 'w600':
        return FontWeight.w600;
      case 'w700':
        return FontWeight.w700;
      case 'w800':
        return FontWeight.w800;
      case 'w900':
        return FontWeight.w900;
      default:
        return null;
    }
  }
}
