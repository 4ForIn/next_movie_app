import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageAsString {
  // String to image:
  static Image? fromBase64Str(String? base64Str) {
    final String? _s = base64Str;
    if (_s == null) {
      return null;
    }
    final Image _img = Image.memory(
      base64Decode(_s),
      fit: BoxFit.fill, //?
    );

    return _img;
  }

  // image to String:
  static String base64String(Uint8List data) {
    return base64UrlEncode(data);
  }
}
