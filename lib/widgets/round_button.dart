import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



final Color kPrimaryColor = Hexcolor('#53B175');
final Color kShadowColor = Hexcolor('#A8A8A8');
final Color kBlackColor = Hexcolor('#181725');
final Color kSubtitleColor = Hexcolor('#7C7C7C');
final Color kSecondaryColor = Hexcolor('#F2F3F2');
final Color kBorderColor = Hexcolor('#E2E2E2');

final TextStyle kTitleStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: kBlackColor,
);

final TextStyle kDescriptionStyle = TextStyle(
  color: kSubtitleColor,
  fontSize: 13,
);
class Hexcolor extends Color {
  static const MethodChannel _channel = const MethodChannel('hexcolor');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  Hexcolor(final String hexColor) : super(_getColorFromHex(hexColor));
}
