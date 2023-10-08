// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

enum Images {
  appLogo("appLogo"),
  settings("settings"),
  correct("correct"),
  wrong("wrong"),
  question_mark("question_mark"),
  left_arrow("left_arrow"),
  readyDecks("readyDecks"),
  google("google"),
  emptyDeck("emptyDeck"),
  curriculum("curriculum"),
  home("home");

  final String value;
  const Images(this.value);

  Image get png => Image.asset("assets/images/$value.png");
  SvgPicture get svg => SvgPicture.asset(
        "assets/images/$value.svg",
        width: 4.h,
        height: 4.h,
      );
}
