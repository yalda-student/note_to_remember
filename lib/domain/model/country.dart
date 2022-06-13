import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';

class Country {
  final String name;
  final Widget flag;
  final Locale locale;

  Country({required this.name, required this.flag, required this.locale});
}

final countries = [
  Country(
      name: 'English',
      locale: const Locale('en', 'US'),
      flag: Row(
        children: [
          SizedBox(
              width: 30,
              height: 30,
              child: Flag.fromCode(FlagsCode.US, height: 20)),
          const SizedBox(width: 8),
          const Text('English')
        ],
      )),
  Country(
      name: 'فارسی',
      locale: const Locale('fa', 'IR'),
      flag: Row(
        children: [
          SizedBox(
              width: 30,
              height: 30,
              child: Flag.fromCode(FlagsCode.IR, height: 20)),
          const SizedBox(width: 8),
          const Text('فارسی')
        ],
      )),
];
