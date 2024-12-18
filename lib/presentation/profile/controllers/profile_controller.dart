import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/common/constants/enums/request_enum.dart';
import 'package:hog_v2/common/routes/app_routes.dart';
import 'package:hog_v2/common/utils/utils.dart';
import 'package:hog_v2/data/models/profile_model.dart';
import 'package:hog_v2/data/models/user_model.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';
import 'package:hog_v2/data/repositories/account_repo.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileController extends GetxController {
  @override
  void onInit() {
    getMyProfile();
    super.onInit();
  }

  String imageProfile =
      "https://img.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?w=740&t=st=1702746365~exp=1702746965~hmac=d69d2e417b17c8e24a04eabd7a5d0ca923eb3a5806a83f576d1f19f0da10318f";

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();

    isEdited.close();
    imagePicked.close();
    super.onClose();
  }

  RxBool isEdited = false.obs;

  changeIsEdit() {
    isEdited.value = !isEdited.value;
  }

  TextEditingController nameController = TextEditingController(text: "لا يوجد");
  TextEditingController phoneController = TextEditingController(text: "لا يوجد");
  TextEditingController addressController = TextEditingController(text: "لا يوجد");

  RequestStatus getProfileStatus = RequestStatus.begin;
  RequestStatus logOutStatus = RequestStatus.begin;
  RequestStatus deleteProfileStatus = RequestStatus.begin;
  RequestStatus updateProfileStatus = RequestStatus.begin;

  updateGetProfileStatus(RequestStatus status) => getProfileStatus = status;

  updateLogOutStatus(RequestStatus status) => logOutStatus = status;

  updateEditProfileStatus(RequestStatus status) => updateProfileStatus = status;

  updateDeleteProfileStatus(RequestStatus status) => deleteProfileStatus = status;

  RxString imagePicked = "".obs;

  getImagePicked() async {
    imagePicked.value = await GetIt.instance<Utils>().imagePicker(ImageSource.gallery) ?? "";
  }

  final AccountRepo _repo = AccountRepo();
  ProfileResponse? prfoileResponse;

  Future<void> getMyProfile() async {
    updateGetProfileStatus(RequestStatus.loading);
    update(["profilePage"]);
    var response = await _repo.getMyProfile();
    if (response.success) {
      prfoileResponse = ProfileResponse.fromJson(response.data);
      GetIt.instance<CacheProvider>().setUserImage(prfoileResponse!.data.image);
      phoneController = TextEditingController(text: prfoileResponse!.data.phone ?? "لا يوجد");
      nameController = TextEditingController(text: prfoileResponse!.data.fullName ?? "لا يوجد");
      addressController = TextEditingController(text: prfoileResponse!.data.location ?? "لا يوجد");
      updateGetProfileStatus(RequestStatus.success);
      if (kDebugMode) {
        print(response.data);
      }
    } else if (!response.success) {
      if (response.errorMessage == "لا يوجد اتصال بالانترنت") {
        updateGetProfileStatus(RequestStatus.noInternentt);
      } else {
        updateGetProfileStatus(RequestStatus.onError);
      }
      Get.snackbar("حدث خطأ", response.errorMessage!);
    }
    update(["profilePage"]);
  }

  Future<void> updateProfile() async {
    updateEditProfileStatus(RequestStatus.loading);
    update();
    User user = User(
        id: GetIt.instance<CacheProvider>().getUserId(),
        fullName: nameController.text.trim(),
        phone: phoneController.text.trim(),
        image: imagePicked.value);
    var response = await _repo.updateProfile(user);
    if (response.success) {
      if (kDebugMode) {
        print(response.data);
      }
      updateEditProfileStatus(RequestStatus.success);
      prfoileResponse = ProfileResponse.fromJson(response.data);
      GetIt.instance<CacheProvider>().setUserName(prfoileResponse!.data.fullName!);
      update();
      phoneController = TextEditingController(text: prfoileResponse!.data.phone ?? "لا يوجد");
      nameController = TextEditingController(text: prfoileResponse!.data.fullName ?? "لا يوجد");
      addressController = TextEditingController(text: prfoileResponse!.data.location ?? "لا يوجد");
      Get.back();
      getMyProfile();
    } else {
      updateEditProfileStatus(RequestStatus.begin);
      update();
      Get.snackbar("حدث خطأ", response.errorMessage ?? "حدث خطأ في الاتصال مع الانترنت");
    }
  }

  Future<void> logOut() async {
    updateLogOutStatus(RequestStatus.loading);
    update(["logoutButton"]);
    var response = await _repo.signOut();
    if (response.success) {
      if (kDebugMode) {
        print(response.data);
      }
      updateLogOutStatus(RequestStatus.success);
      GetIt.instance<CacheProvider>().clearAppToken();
      Get.offAllNamed(AppRoute.loginPageRoute);
    } else if (!response.success) {
      updateLogOutStatus(RequestStatus.onError);
      Get.snackbar("حدث خطأ", response.errorMessage!);
      update(["logoutButton"]);
    }
  }

  Future<void> deleteProfile() async {
    updateDeleteProfileStatus(RequestStatus.loading);
    update(["deleteProfileButton"]);
    var response = await _repo.deleteProfile();
    // var response = AppResponse(success: true, data: "", errorMessage: "sadas");
    // await Future.delayed(Duration(seconds: 2));

    if (response.success) {
      if (kDebugMode) {
        print(response.data);
      }
      updateDeleteProfileStatus(RequestStatus.success);
      GetIt.instance<CacheProvider>().clearAppToken();
      Get.offAllNamed(AppRoute.loginPageRoute);
    } else if (!response.success) {
      updateDeleteProfileStatus(RequestStatus.onError);
      Get.snackbar("حدث خطأ", response.errorMessage!);
      update(["deleteProfileButton"]);
    }
  }
}
