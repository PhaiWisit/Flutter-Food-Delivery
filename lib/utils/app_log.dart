// ignore_for_file: unused_element, unnecessary_brace_in_string_interps

import 'dart:developer';

class AppLog {
  // Blue text
  static void _logBlue(String msg) {
    log('\x1B[34m$msg\x1B[0m');
  }

// Green text
  static void _logGreen(String msg) {
    log('\x1B[32m$msg\x1B[0m');
  }

// Yellow text
  static void _logYellow(String msg) {
    log('\x1B[33m$msg\x1B[0m');
  }

// Red text
  static void _logRed(String msg) {
    log('\x1B[31m$msg\x1B[0m');
  }

  static tap(String message) {
    _logYellow('onTap : ${message}');
  }

  static error(String message) {
    _logRed('Error : ${message}');
  }

  static info(String message) {
    _logBlue('Information : ${message}');
  }

  static success(String message) {
    _logGreen('Success : ${message}');
  }
}
