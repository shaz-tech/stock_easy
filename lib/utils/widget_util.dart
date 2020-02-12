import 'package:flutter/material.dart';

class WidgetUtill {
  static Widget circularDot(double size, double margin) => Container(
        height: size,
        width: size,
        margin: EdgeInsets.only(left: margin, right: margin),
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          shape: BoxShape.circle,
        ),
      );
}
