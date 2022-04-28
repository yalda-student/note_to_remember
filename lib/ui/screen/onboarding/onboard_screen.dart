import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:yalda_students_notes/core/common/lang.dart';
import 'package:yalda_students_notes/app/main.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';

import 'bloc/language_bloc.dart';
import 'country.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(assetName, width: width);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        bodyTextStyle: bodyStyle,
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero);

    return BlocBuilder<LanguageBloc, LanguageState>(
      buildWhen: (previous, current) => current is LanguageChangeEvent,
      builder: (context, state) {
        return IntroductionScreen(
          key: ValueKey('${context.locale}'),
          globalBackgroundColor: Colors.white,
          globalHeader: const Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 16, right: 16),
                child: Icon(Iconsax.stickynote, size: 30),
              ),
            ),
          ),
          globalFooter: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              child: Text(LocaleKeys.lets_go.tr(),
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold)),
              onPressed: () => _onIntroEnd(context),
            ),
          ),
          pages: [
            PageViewModel(
                title: LocaleKeys.select_language.tr(),
                bodyWidget: const _LanguageDropDown(),
                image: _buildImage('asset/image/lang.png'),
                decoration: pageDecoration),
            PageViewModel(
                title: LocaleKeys.Colorful_Notes.tr(),
                body: LocaleKeys.note_tutorial.tr(),
                image: _buildImage('asset/image/notes.jpg'),
                decoration: pageDecoration),
            PageViewModel(
                title: LocaleKeys.find_quickly.tr(),
                body: LocaleKeys.search_easily.tr(),
                image: _buildImage('asset/image/search.png'),
                decoration: pageDecoration),
            PageViewModel(
                title: LocaleKeys.Manage_Notes.tr(),
                body: LocaleKeys.categorize_notes.tr(),
                decoration: pageDecoration,
                image: _buildImage('asset/image/category.jpg')),
          ],
          onDone: () => _onIntroEnd(context),
          showSkipButton: false,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: true,
          back: const Icon(Icons.arrow_back),
          next: const Icon(Icons.arrow_forward),
          done: Text(LocaleKeys.done.tr(),
              style: const TextStyle(fontWeight: FontWeight.w600)),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(12.0, 12.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(24.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        );
      },
    );
  }
}

class _LanguageDropDown extends StatelessWidget with AppLanguage {
  const _LanguageDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<Locale>(
      value: EasyLocalization.of(context)!.currentLocale,
      icon: const Icon(Iconsax.arrow_circle_down),
      onChanged: (Locale? newLocale) {
        onLanguageChange(context, newLocale ?? const Locale('en', 'US'));
        context.read<LanguageBloc>().add(LanguageChangeEvent());
      },
      items: countries
          .map<DropdownMenuItem<Locale>>(
              (Country country) => DropdownMenuItem<Locale>(
                    value: country.locale,
                    child: country.flag,
                  ))
          .toList(),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
