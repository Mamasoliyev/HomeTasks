import 'package:flutter/material.dart';

extension BuildContainerExt on Widget {
  Container buildContainer({
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    AlignmentGeometry? alignment,
    Color? color,
    double? borderRadius,
    BoxBorder? border,
    BoxShadow? boxshadow,
  }) {
    return Container(
      width: width ?? 100,
      height: height ?? 100,
      alignment: alignment ?? Alignment.center,
      padding: padding ?? EdgeInsets.all(0),
      margin: margin ?? EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        border: border,
        boxShadow: boxshadow != null ? [boxshadow] : null,
      ),
      child: this,
    );
  }
}
