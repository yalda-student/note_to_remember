import 'package:flutter/material.dart';

class ColorManager {
  static const Color primaryDark = Color(0xff121212);
  static const Color lightGray = Color(0xffE8EBED);
  static const Color bottomNavigationDarkColor = Color(0xff242424);
  static const Color tabBarDarkColor = Color(0xff262626);
  static const Color unselectedTabLabelDarkColor = Color(0xff5C5C5C);
  static const Color radioButtonColor = Color(0xff6996EA);
  static const Color activeColor = Colors.white;

  List<CategoryColor> categoryColors = [
    CategoryColor(
        iconColor: const Color(0xffe86aff),
        lightBackgroundColor: const Color(0xffe86aff),
        darkBackgroundColor: const Color(0xffF2A6FF)),
    CategoryColor(
        iconColor: const Color(0xffFFC545),
        lightBackgroundColor: const Color(0xffFFE3A6),
        darkBackgroundColor: const Color(0x14ffdd90)),
    CategoryColor(
        iconColor: const Color(0xff54D25D),
        lightBackgroundColor: const Color(0xffA9E8AD),
        darkBackgroundColor: const Color(0x1499e49e)),
    CategoryColor(
        iconColor: const Color(0xff428bfa),
        lightBackgroundColor: const Color(0xff9CC2FC),
        darkBackgroundColor: const Color(0xff8ebafc)),
    CategoryColor(
        iconColor: const Color(0xffFF6A6A),
        lightBackgroundColor: const Color(0xffFFA7A7),
        darkBackgroundColor: const Color(0x21ffa6a6)),
    CategoryColor(
        iconColor: const Color(0xff54b9d2),
        lightBackgroundColor: const Color(0xffB1DFEA),
        darkBackgroundColor: const Color(0x1499d5e4)),
    CategoryColor(
        iconColor: const Color(0xff6affd2),
        lightBackgroundColor: const Color(0xffB7FFE9),
        darkBackgroundColor: const Color(0x146affe4)),
  ];

  static const colors = <Color>[
    Color(0xfff8f8f8),
    Color(0xffbbdcf8),
    Color(0xffF8CBBB),
    Color(0xfff8f4bb),
    Color(0xffbf8c82),
    Color(0xffc2f8bb),
    Color(0xffbbcef8),
    Color(0xffe1bbf8),
    Color(0xff9dc89f),
    Color(0xffff707e),
    Color(0xffd3fcff),
    Color(0xffc8c09d),
    Color(0xfff8bbe2),
  ];

 static List<NoteColor> noteColors = [
    NoteColor(
        lightColor: const Color(0xfff5f6f7),
        darkColor: const Color(0xff111d29)),
    NoteColor(
        lightColor: const Color(0xffebf8ff),
        darkColor: const Color(0xff00144a)),
    NoteColor(
        lightColor: const Color(0xffdafdf5),
        darkColor: const Color(0xff012931)),
    NoteColor(
        lightColor: const Color(0xfff5fae5),
        darkColor: const Color(0xff0e2b16)),
    NoteColor(
        lightColor: const Color(0xfffff8d6),
        darkColor: const Color(0xff450b00)),
    NoteColor(
        lightColor: const Color(0xffffeaf4),
        darkColor: const Color(0xff350000)),
    NoteColor(
        lightColor: const Color(0xfffff0fa),
        darkColor: const Color(0xff28004a)),
    NoteColor(
        lightColor: const Color(0xfff1ecff),
        darkColor: const Color(0xff1c0c6e)),
  ];
}

class CategoryColor {
  final Color iconColor;
  final Color lightBackgroundColor;
  final Color darkBackgroundColor;

  CategoryColor(
      {required this.iconColor,
      required this.lightBackgroundColor,
      required this.darkBackgroundColor});
}

class NoteColor {
  final Color lightColor;
  final Color darkColor;

  NoteColor({required this.lightColor, required this.darkColor});
}
