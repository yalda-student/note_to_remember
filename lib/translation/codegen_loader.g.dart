// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "profileTitle": "My Notes",
  "notes": "Notes",
  "notesList": "List Notes",
  "search": "Search",
  "categories": "Categories",
  "setting": "Setting",
  "startSearching": "Start Searching",
  "editNote": "Edit Note",
  "title": "Title",
  "content": "Content",
  "startTyping": "Start Typing",
  "listCategories": "List Categories",
  "language": "Language",
  "add_note": "Add Note",
  "content_Cannot_Be_Empty": "content Can not Be Empty.",
  "favorite_Notes": "Favorite Notes",
  "any_note": "You don't have any note.",
  "theme": "Theme",
  "about": "About us"
};
static const Map<String,dynamic> fa = {
  "profileTitle": "یادداشت های من",
  "notes": "یادداشت ها",
  "notesList": "لیست یادداشت ها",
  "search": "جستجو",
  "categories": "دسته ها",
  "setting": "تنظیمات",
  "startSearching": "جستجو را آغاز کنید",
  "editNote": "ویرایش یادداشت",
  "title": "عنوان",
  "content": "محتوا",
  "startTyping": "تایپ کنید",
  "listCategories": "لیست دسته ها",
  "language": "زبان",
  "add_note": "اضافه کردن یادداشت",
  "content_Cannot_Be_Empty": "محتوا نمی تواند خال باشد",
  "favorite_Notes": "یادداشت های مورد علاقه",
  "any_note": "شما یادداشتی ندارید",
  "theme": "تم",
  "about": "درباره ما"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "fa": fa};
}
