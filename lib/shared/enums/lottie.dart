import 'package:lottie/lottie.dart';

enum CustomLottie {
  congrats("congrats"),
  cup("cup");

  final String value;
  const CustomLottie(this.value);

  LottieBuilder get lottieAsset => Lottie.asset("assets/jsons/$value.json");
}
