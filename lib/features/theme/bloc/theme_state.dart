import 'package:flutter/material.dart';

abstract class ThemeState {
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  Color _cardColor = Colors.white;

  Color get backgroundColor => _backgroundColor;
  Color get textColor => _textColor;
  Color get cardColor => _cardColor;

  set backgroundColor(Color color) {
    _backgroundColor = color;
  }

  set textColor(Color color) {
    _textColor = color;
  }

  set cardColor(Color color) {
    _cardColor = color;
  }

  ThemeState();
}

class InitialThemeState extends ThemeState {
  @override
  Color backgroundColor = Colors.white;
  @override
  final textColor = Colors.black;
  @override
  final cardColor = Colors.white;

//
}

class DarkThemeState extends ThemeState {
  @override
  final backgroundColor = const Color(0xFF121212);
  @override
  final textColor = Colors.white;
  @override
  final cardColor = const Color.fromRGBO(36, 36, 36, 1);
  // final cardColor = const Color(0xFF2C2C2C);

  final double defaultPadding = 16.0;
}

class LightThemeState extends ThemeState {
  @override
  final backgroundColor = Colors.white;
  @override
  final textColor = Colors.black;
  @override
  // final cardColor = Colors.white30;
  final cardColor = Colors.white;
}
