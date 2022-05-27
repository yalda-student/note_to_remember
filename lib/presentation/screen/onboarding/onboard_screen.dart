import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:yalda_students_notes/core/common/lang.dart';
import 'package:yalda_students_notes/data/model/country.dart';
import 'package:yalda_students_notes/gen/assets.gen.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/main.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';
import 'package:yalda_students_notes/presentation/screen/onboarding/bloc/language_bloc.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    final bodyStyle = TextStyle(fontSize: FontSize.onBoardBody(context));

    final pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: FontSize.onBoardTitle(context),
            fontWeight: FontWeight.w700),
        bodyTextStyle: bodyStyle,
        bodyPadding: const EdgeInsets.fromLTRB(
            AppPadding.p16, AppPadding.p0, AppPadding.p16, AppPadding.p16),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero);

    return BlocBuilder<OnBoardingBloc, OnBoardingState>(
      buildWhen: (previous, current) =>
          current is OnBoardingLanguageChangeEvent,
      builder: (context, state) {
        return IntroductionScreen(
          key: ValueKey('${context.locale}'),
          globalBackgroundColor: Colors.white,
          globalHeader: const Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Padding(
                padding:
                    EdgeInsets.only(top: AppPadding.p16, right: AppPadding.p16),
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
                      fontSize: FontSize.s16, fontWeight: FontWeight.bold)),
              onPressed: () => _onIntroEnd(context),
            ),
          ),
          pages: [
            PageViewModel(
                title: LocaleKeys.select_language.tr(),
                bodyWidget: const _LanguageDropDown(),
                image: _buildImage(Assets.image.lang.path),
                decoration: pageDecoration),
            PageViewModel(
                title: LocaleKeys.Colorful_Notes.tr(),
                body: LocaleKeys.note_tutorial.tr(),
                image: _buildImage(Assets.image.notes.path),
                decoration: pageDecoration),
            PageViewModel(
                title: LocaleKeys.find_quickly.tr(),
                body: LocaleKeys.search_easily.tr(),
                image: _buildImage(Assets.image.search.path),
                decoration: pageDecoration),
            PageViewModel(
                title: LocaleKeys.Manage_Notes.tr(),
                body: LocaleKeys.categorize_notes.tr(),
                decoration: pageDecoration,
                image: _buildImage(Assets.image.category.path)),
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
              ? const EdgeInsets.all(AppPadding.p12)
              : const EdgeInsets.fromLTRB(
                  AppPadding.p8, AppPadding.p4, AppPadding.p8, AppPadding.p4),
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

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(assetName, width: width);
  }
}

class _LanguageDropDown extends StatelessWidget with AppLanguage {
  const _LanguageDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: DropdownButtonFormField2<Locale>(
        value: EasyLocalization.of(context)!.currentLocale,
        icon: const Icon(Iconsax.arrow_circle_down),
        onChanged: (Locale? newLocale) {
          onLanguageChange(context, newLocale ?? const Locale('en', 'US'));
          context.read<OnBoardingBloc>().add(OnBoardingLanguageChangeEvent());
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
      ),
    );
  }
}
