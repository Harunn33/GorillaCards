import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

enum Images {
  appLogo("appLogo"),
  settings("settings");

  final String value;
  const Images(this.value);

  Image get png => Image.asset("assets/images/$value.png");
  SvgPicture get svg => SvgPicture.asset(
        "assets/images/$value.svg",
        width: 4.h,
        height: 4.h,
      );
}
