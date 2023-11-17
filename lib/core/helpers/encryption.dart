import 'dart:math';

import 'package:encrypt/encrypt.dart' as enc;

class Encryption {
  static enc.Encrypted encrypt(String keyString, String plainText) {
    final key = enc.Key.fromUtf8(keyString);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final initVector = enc.IV.fromUtf8(keyString.substring(0, 16));
    enc.Encrypted encryptedData = encrypter.encrypt(plainText, iv: initVector);
    return encryptedData;
  }

  static String decrypt(String keyString, enc.Encrypted encryptedData) {
    final key = enc.Key.fromUtf8(keyString);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final initVector = enc.IV.fromUtf8(keyString.substring(0, 16));
    return encrypter.decrypt(encryptedData, iv: initVector);
  }

  static String generateRandomKey(int length) {
    const validCharacters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      buffer.write(validCharacters[random.nextInt(validCharacters.length)]);
    }
    return buffer.toString();
  }
}
