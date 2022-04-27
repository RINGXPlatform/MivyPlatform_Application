import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:ring_mobile/contants/keys.dart';
import 'package:ring_mobile/data/network/common_resp.dart';

encryption(String plainText) {
  final key = Key.fromUtf8(MOBILE_ENCRYPTION_KEY);
  final iv = IV.fromUtf8(MOBILE_ENCRYPTION_IV);

  var encrypter = Encrypter(AES(key, mode: AESMode.cbc)); //AES-cbc-PKCS7
  var hMacSha256 = new Hmac(sha256, utf8.encode(MOBILE_ENCRYPTION_KEY)); // HMAC-SHA256

  var encryptedValue = encrypter.encrypt(plainText, iv: iv).base64.replaceAll("\n", "");
  var mac = hMacSha256.convert(utf8.encode(iv.base64 + encryptedValue));

//  var encData = EncryptData(mac: mac.toString(), value: encryptedValue).toJson();
  var encData = EncryptData(mac: mac.toString(), value: encryptedValue).toString();
  print(encData);
  return encData;
}

decryption(EncryptData cipher, {bool doCheckMac = true}) {
  final key = Key.fromUtf8(SERVER_ENCRYPTION_KEY);
  final iv = IV.fromUtf8(SERVER_ENCRYPTION_IV);

  var encrypter = Encrypter(AES(key, mode: AESMode.cbc)); //AES-cbc-PKCS7
  var hMacSha256 = new Hmac(sha256, utf8.encode(SERVER_ENCRYPTION_KEY)); // HMAC-SHA256

  var mac = hMacSha256.convert(utf8.encode(iv.base64 + cipher.value));
  var decrypted = "";

  if (doCheckMac) {
    if (mac.toString() == cipher.mac) {
      decrypted = encrypter.decrypt64(cipher.value, iv: iv);
    } else
      throw Exception("Use secure network");
  } else {
    decrypted = encrypter.decrypt64(cipher.value, iv: iv);
  }
  return decrypted;
}

decryptionMobileSide(EncryptData cipher, {bool doCheckMac = true}) {
  final key = Key.fromUtf8(MOBILE_ENCRYPTION_KEY);
  final iv = IV.fromUtf8(MOBILE_ENCRYPTION_IV);

  var encrypter = Encrypter(AES(key, mode: AESMode.cbc)); //AES-cbc-PKCS7
  var hMacSha256 = new Hmac(sha256, utf8.encode(MOBILE_ENCRYPTION_KEY)); // HMAC-SHA256

  var mac = hMacSha256.convert(utf8.encode(iv.base64 + cipher.value));
  var decrypted = "";

  if (doCheckMac) {
    if (mac.toString() == cipher.mac) {
      decrypted = encrypter.decrypt64(cipher.value, iv: iv);
    } else
      throw Exception("Use secure network");
  } else {
    decrypted = encrypter.decrypt64(cipher.value, iv: iv);
  }
  print(decrypted);
  return decrypted;
}
