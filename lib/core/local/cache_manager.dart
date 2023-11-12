import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  void setLoginStatus(bool? isLogin) {
    final box = GetStorage();
    box.write('isLogin', isLogin);
  }

  bool? getLoginStatus() {
    final box = GetStorage();
    return box.read('isLogin');
  }

  Future<void> removeLoginToken() async {
    final box = GetStorage();
    await box.remove('isLogin');
  }

  void setSliderWatchStatus(bool? isWatched) {
    final box = GetStorage();
    box.write('isWatched', isWatched);
  }

  bool? getSliderWatchStatus() {
    final box = GetStorage();
    return box.read('isWatched');
  }

  Future<void> removeSlidedWatchStatus() async {
    final box = GetStorage();
    await box.remove('isWatched');
  }

  Future<void> removeAllToken() async {
    final box = GetStorage();
    await box.erase();
  }

  void setUserType(String? userType) {
    final box = GetStorage();
    box.write('userType', userType);
  }

  String? getUserType() {
    final box = GetStorage();
    return box.read('userType');
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove('userType');
  }
}
