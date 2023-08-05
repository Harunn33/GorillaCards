import 'package:flutter/material.dart';

enum Images {
  appLogo("appLogo");

  final String value;
  const Images(this.value);

  Image get png => Image.asset("assets/images/$value.png");
}
