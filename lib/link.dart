import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:developer';

import 'package:encrypt/encrypt.dart';

// ваш ключ должен быть длиной 32 байта для AES-256
final key = Key.fromUtf8('cRfUjXn2r4u7x!A%D*G-KaPdSgVkYp3s'); // замените на свой секретный ключ
final iv = IV.fromLength(16); // в CBC-режиме, длина IV обычно равна размеру блока шифрования, т.е. 16 байт


String decrypt(String encryptedText) {

  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  final encrypted = Encrypted.fromBase64(encryptedText);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  return decrypted;
}

class Link {
  final int id;
  final String url;
  final String createdAt;

  Link({required this.id, required this.url, required this.createdAt});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      id: json['id'],
      url: decrypt(json['url']),
      createdAt: json['created_at'],
    );
  }


}