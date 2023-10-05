// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:gorillacards/models/SigninModel.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../di.dart';

class SigninController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool passwordObscure = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  void allFocusNodeUnfocus() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  Future<void> handleSignin() async {
    Get.closeAllSnackbars();
    final SigninModel signinModel = SigninModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    try {
      await supabase.auth.signInWithPassword(
        password: signinModel.password,
        email: signinModel.email,
      );
      Get.offAllNamed(Routes.HOME);
    } on AuthException catch (error) {
      isLoading.toggle();
      CustomSnackbar(
        title: AppStrings.error.tr,
        message: error.message,
      );
    } catch (e) {
      isLoading.toggle();
      CustomSnackbar(
        title: AppStrings.error.tr,
        message: AppStrings.invalidEmailOrPassword.tr,
      );
    }
  }

  String generateRandomString() {
    final random = Random.secure();
    return base64Url.encode(List<int>.generate(16, (_) => random.nextInt(256)));
  }

  Future<void> handleGoogleSignin() async {
    isLoading.toggle();
    Get.closeAllSnackbars();
    try {
      await signInWithGoogle();
      Get.offAllNamed(Routes.HOME);
    } on AuthException catch (error) {
      isLoading.toggle();
      CustomSnackbar(
        title: AppStrings.error.tr,
        message: error.message,
      );
    } catch (e) {
      isLoading.toggle();
      CustomSnackbar(
        title: AppStrings.error.tr,
        message: AppStrings.invalidEmailOrPassword.tr,
      );
    }
  }

  Future<AuthResponse> signInWithGoogle() async {
    // Just a random string
    final rawNonce = generateRandomString();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    /// TODO: update the client ID with your own
    ///
    /// Client ID that you registered with Google Cloud.
    /// You will have two different values for iOS and Android.
    final clientId = Platform.isIOS
        ? dotenv.get("IOS_CLIENT_ID")
        : dotenv.get("ANDROID_CLIENT_ID");

    /// reverse DNS form of the client ID + `:/` is set as the redirect URL
    final redirectUrl = '${clientId.split('.').reversed.join('.')}:/';

    /// Fixed value for google login
    const discoveryUrl =
        'https://accounts.google.com/.well-known/openid-configuration';

    const appAuth = FlutterAppAuth();

    // authorize the user by opening the consent page
    final result = await appAuth.authorize(
      AuthorizationRequest(
        clientId,
        redirectUrl,
        discoveryUrl: discoveryUrl,
        nonce: hashedNonce,
        scopes: [
          'openid',
          'email',
        ],
      ),
    );

    if (result == null) {
      throw 'Could not find AuthorizationResponse after authorizing';
    }

    // Request the access and id token to google
    final tokenResult = await appAuth.token(
      TokenRequest(
        clientId,
        redirectUrl,
        authorizationCode: result.authorizationCode,
        discoveryUrl: discoveryUrl,
        codeVerifier: result.codeVerifier,
        nonce: result.nonce,
        scopes: [
          'openid',
          'email',
        ],
      ),
    );

    final idToken = tokenResult?.idToken;

    if (idToken == null) {
      throw 'Could not find idToken from the token response';
    }

    return supabase.auth.signInWithIdToken(
      provider: Provider.google,
      idToken: idToken,
      accessToken: tokenResult?.accessToken,
      nonce: rawNonce,
    );
  }
}
