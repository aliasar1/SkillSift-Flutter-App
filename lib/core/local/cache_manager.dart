import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  void setLoginStatus(bool isLogin) {
    final box = GetStorage();
    box.write('isLogin', isLogin);
  }

  String? getLoginStatus() {
    final box = GetStorage();
    return box.read('isLogin');
  }

  Future<void> removeLoginToken() async {
    final box = GetStorage();
    await box.remove('isLogin');
  }
}
