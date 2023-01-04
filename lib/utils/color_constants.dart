import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color gray51 = fromHex('#f8f8fa');

  static Color whiteA7003f = fromHex('#3fffffff');

  static Color red600 = fromHex('#e64040');

  static Color black9003f = fromHex('#3f000000');

  static Color gray50 = fromHex('#f7fcff');

  static Color blue40019 = fromHex('#1941b6e6');

  static Color gray9004c = fromHex('#4c1f1f1f');

  static Color gray908 = fromHex('#1d242e');

  static Color whiteA7004c = fromHex('#4cffffff');

  static Color blue800 = fromHex('#0957de');

  static Color amber500 = fromHex('#fbbc04');

  static Color gray800 = fromHex('#49454f');

  static Color gray900 = fromHex('#1e1e1e');

  static Color bluegray100 = fromHex('#d9d9d9');

  static Color blue80033 = fromHex('#330957de');

  static Color gray200 = fromHex('#ededed');

  static Color black9000c = fromHex('#0c000000');

  static Color gray100 = fromHex('#f5f5f5');

  static Color bluegray801 = fromHex('#474a56');

  static Color bluegray800 = fromHex('#283f4b');

  static Color indigo100 = fromHex('#c8d1e1');

  static Color blue80019 = fromHex('#190957de');

  static Color bluegray400 = fromHex('#8a8a8a');

  static Color gray9007f = fromHex('#7f1f1f1f');

  static Color gray900B2 = fromHex('#b223282d');

  static Color blue100 = fromHex('#b8d2ff');

  static Color whiteA700 = fromHex('#ffffff');

  static Color blue8000c = fromHex('#0c0957de');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
