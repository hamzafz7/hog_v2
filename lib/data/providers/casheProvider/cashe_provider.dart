// import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

class CacheProvider {
  late GetStorage _getStorage;

  init() {
    _getStorage = GetStorage();
  }

  getIsOnBoardingOpened() {
    return _getStorage.read("onboarding");
  }

  setIsOnBoardingOpened(bool value) {
    return _getStorage.write("onboarding", value);
  }

  getAppToken() {
    return _getStorage.read("token");
  }

  setUserName(String? name) {
    _getStorage.write("name", name);
  }

  setUserId(int? id) {
    _getStorage.write("id", id);
  }

  getUserId() {
    return _getStorage.read("id");
  }

  setUserImage(String? image) {
    _getStorage.write("image", image);
  }

  getUserImage() {
    return _getStorage.read("image");
  }

  setAppToken(String val) {
    _getStorage.write("token", val);
  }

  clearAppToken() {
    _getStorage.remove("token");
  }

  getUserName() {
    return _getStorage.read("name");
  }

  setUserPhone(String? val) {
    _getStorage.write("phone", val);
  }

  getUserPhone() {
    return _getStorage.read("phone");
  }

  getDeviceId() {
    return _getStorage.read("device_id");
  }

  bool getAppTheme() {
    return _getStorage.read("is_Dark") ?? false;
  }

  setAppTheme(bool val) {
    _getStorage.write("is_Dark", val);
  }

  setdeviceToken(String? val) {
    _getStorage.write("device_token", val);
  }

  getdeviceToken() {
    return _getStorage.read("device_token");
  }

  setUserType(String? val) {
    _getStorage.write("type", val);
  }

  getUserType() {
    return _getStorage.read("type");
  }

  Future<void> setDeviceId(String uuid) async {
    await _getStorage.write("device_id", uuid);
  }

  Future<String> getOrCreateUUID() async {
    String? uuid = GetIt.instance<CacheProvider>().getDeviceId();
    if (uuid == null) {
      uuid = Uuid().v4();
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      uuid = "$uuid-$timestamp";
      await setDeviceId(uuid);
    }

    return uuid;
  }
}
