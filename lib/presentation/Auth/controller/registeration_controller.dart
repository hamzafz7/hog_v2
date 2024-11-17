import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/common/constants/enums/request_enum.dart';
import 'package:hog_v2/common/routes/app_routes.dart';
import 'package:hog_v2/data/models/auth_model.dart';
import 'package:hog_v2/data/models/user_model.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';
import 'package:hog_v2/data/repositories/account_repo.dart';

class RegisterationController extends GetxController {
  @override
  void onClose() {
    nameController.dispose();
    loginPasswordController.dispose();
    registerPasswordController.dispose();
    confirmPasswordController.dispose();
    loginPhoneController.dispose();
    registerPhoneController.dispose();
    super.onClose();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController loginPhoneController = TextEditingController();
  TextEditingController registerPhoneController = TextEditingController();

  var loginPageFormKey = GlobalKey<FormState>();
  var registerPageFormKey = GlobalKey<FormState>();

  RequestStatus loginState = RequestStatus.begin;

  RequestStatus registerStatus = RequestStatus.begin;

  final AccountRepo _repo = AccountRepo();

  userLogin(Size size) {
    if (!(loginPageFormKey.currentState?.validate() ?? false)) return;

    loginState = RequestStatus.loading;
    update();
    _login(size).whenComplete(() {
      loginState = RequestStatus.success;
      update();
    }).catchError((error) {
      loginState = RequestStatus.onError;
      update();
    });
  }

  Future<void> _login(Size size) async {
    try {
      final user = User(
          password: loginPasswordController.text.trim(), phone: loginPhoneController.text.trim());
      final response = await _repo.userLogin(user, size);

      if (response.success) {
        if (kDebugMode) {
          print(response.data);
        }
        final authResponse = AuthResponse.fromJson(response.data);
        await _saveUserData(authResponse);
        Get.snackbar("مرحباً !!", authResponse.message!);
        Get.offAllNamed(AppRoute.mainPageRoute);
      } else {
        Get.snackbar("حدث خطأ", response.errorMessage!);
      }
    } catch (e) {
      Get.snackbar("حدث خطأ", "حدث خطأ غير متوقع");
    }
  }

  userRegister(Size size) {
    if (!registerPageFormKey.currentState!.validate()) return;

    registerStatus = RequestStatus.loading;
    update();
    _register(size).whenComplete(() {
      registerStatus = RequestStatus.success;
      update();
    }).catchError((error) {
      registerStatus = RequestStatus.onError;
      update();
    });
  }

  Future<void> _register(Size size) async {
    try {
      final user = User(
        password: registerPasswordController.text.trim(),
        phone: registerPhoneController.text.trim(),
        fullName: nameController.text.trim(),
      );

      var response = await _repo.userRegister(user, size);
      if (response.success) {
        if (kDebugMode) {
          print(response.data);
        }
        final authResponse = AuthResponse.fromJson(response.data);
        await _saveUserData(authResponse);
        Get.snackbar("مرحباً !!", authResponse.message!);
        Get.offAllNamed(AppRoute.mainPageRoute);
      } else {
        Get.snackbar("حدث خطأ", response.errorMessage!);
      }
    } catch (e) {
      Get.snackbar("حدث خطأ", "حدث خطأ غير متوقع");
    }
  }

  Future<void> _saveUserData(AuthResponse authResponse) async {
    final cache = GetIt.instance<CacheProvider>();
    await cache.setUserId(authResponse.data!.user!.id!);
    await cache.setUserName(authResponse.data!.user!.fullName!);
    await cache.setAppToken(authResponse.data!.token!);
    await cache.setUserType(authResponse.data!.user!.type);
  }
}
