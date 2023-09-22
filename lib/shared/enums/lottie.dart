import 'package:lottie/lottie.dart';

enum CustomLottie {
  loading("gorilla"),
  congrats("congrats");

  final String value;
  const CustomLottie(this.value);

  LottieBuilder get lottieAsset => Lottie.asset("assets/jsons/$value.json");
}
