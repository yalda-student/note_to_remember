/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetIconGen {
  const $AssetIconGen();

  /// File path: asset/icon/icon.png
  AssetGenImage get icon => const AssetGenImage('asset/icon/icon.png');
}

class $AssetImageGen {
  const $AssetImageGen();

  /// File path: asset/image/category.jpg
  AssetGenImage get category => const AssetGenImage('asset/image/category.jpg');

  /// File path: asset/image/empty.jpg
  AssetGenImage get empty => const AssetGenImage('asset/image/empty.jpg');

  /// File path: asset/image/error-404.png
  AssetGenImage get error404 =>
      const AssetGenImage('asset/image/error-404.png');

  /// File path: asset/image/lang.png
  AssetGenImage get lang => const AssetGenImage('asset/image/lang.png');

  /// File path: asset/image/notes.jpg
  AssetGenImage get notes => const AssetGenImage('asset/image/notes.jpg');

  /// File path: asset/image/search.png
  AssetGenImage get search => const AssetGenImage('asset/image/search.png');
}

class $AssetTranslationGen {
  const $AssetTranslationGen();

  /// File path: asset/translation/en.json
  String get en => 'asset/translation/en.json';

  /// File path: asset/translation/fa.json
  String get fa => 'asset/translation/fa.json';
}

class Assets {
  Assets._();

  static const $AssetIconGen icon = $AssetIconGen();
  static const $AssetImageGen image = $AssetImageGen();
  static const $AssetTranslationGen translation = $AssetTranslationGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
