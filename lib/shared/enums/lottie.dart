import 'package:lottie/lottie.dart';

enum CustomLottie {
  loading("gorilla");

  final String value;
  const CustomLottie(this.value);

  LottieBuilder get lottieAsset => Lottie.asset("assets/jsons/$value.json");
}
