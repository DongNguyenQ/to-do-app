import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Styles {
  static const Widget STDVertSpacing12 = SizedBox(height: 12);
  // static const Widget stdVertSpacing = SizedBox(height: 12);

  static final Color InputBGColor = Colors.grey[300]!;
  static final BorderRadiusGeometry InputBorder = BorderRadius.circular(10);
  static const ShapeBorder BottomModelShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20)
      )
  );
}