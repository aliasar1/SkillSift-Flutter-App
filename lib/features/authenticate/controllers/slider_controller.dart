import 'package:get/get.dart';

class SliderController extends GetxController {
  RxInt _position = 0.obs;

  int get getPosition => _position.value;

  void incrementPosition() {
    if (_position.value < 2) {
      _position++;
    }
  }

  void decrementPosition() {
    if (_position.value > 0) {
      _position--;
    }
  }
}
