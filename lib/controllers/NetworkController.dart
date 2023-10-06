// ignore_for_file: file_names

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  RxInt connectionType = 0.obs;

  final Connectivity connectivity = Connectivity();

  late StreamSubscription streamSubscription;

  @override
  void onInit() {
    super.onInit();
    getConnectionType();
    streamSubscription = connectivity.onConnectivityChanged.listen(updateState);
  }

  Future<void> getConnectionType() async {
    dynamic connectivityResult;

    try {
      connectivityResult = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e);
    }

    return updateState(connectivityResult);
  }

  void updateState(ConnectivityResult connectivityResult) {
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        update();
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        update();
        break;
      default:
        Get.snackbar("Network Error", "Failed to Network Status");
        break;
    }
  }
}
