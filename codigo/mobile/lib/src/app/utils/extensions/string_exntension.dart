import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

extension StringExtension on String {
  String get firstLetterToUpperCase {
    if (this != null)
      return this[0].toUpperCase() + this.substring(1);
    else
      return null;
  }

  String get firstWord {
    List<String> words = this.split(' ');
    if (words.length > 0) {
      return words[0];
    } else {
      return this;
    }
  }

  String get toBase64 {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(this);
  }

  String get fromBase64 {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.decode(this);
  }

  String get cleanString {
    return this.replaceAll(new RegExp(r'[^\w\s]+'), '');
  }

  bool get
  isValidEmail {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(this);
  }

  bool get isValidCpfCnpj {
    return RegExp(
            r'^\d{3}\.\d{3}\.\d{3}\-\d{2}$)|(^\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}$')
        .hasMatch(this);
  }

  bool get isValidCelular {
    return RegExp(r'^\([1-9]{2}\) [0-9]{5}\-[0-9]{4}$').hasMatch(this);
  }

  String capitalize({bool allWords}) {
    if (this == null || this.isEmpty) {
      return '';
    }
    var input = this.toLowerCase();
    if (allWords != null && allWords == true) {
      List<String> words = input.split(' ');
      var capitalized = words.map((word) {
        if (word.isEmpty) {
          return '';
        }
        return word[0].toUpperCase() + word.substring(1);
      }).join(' ');
      return capitalized;
    } else {
      return input[0].toUpperCase() + input.substring(1);
    }
  }

  DateTime toDate({@required String format}) {
    if (this == null) {
      return null;
    }
    return DateFormat(format).parse(this);
  }
}
