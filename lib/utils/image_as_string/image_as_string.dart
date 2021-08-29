import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageAsString {
  static Image fromBase64Str(String base64Str) {
    return Image.memory(
      base64Decode(base64Str),
      fit: BoxFit.fill, //?
    );
  }

  static Uint8List dataFromBase64String(String base64Str) {
    return base64Decode(base64Str);
  }

  static String base64String(Uint8List data) {
    return base64UrlEncode(data);
  }
}
