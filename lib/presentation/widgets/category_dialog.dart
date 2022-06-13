import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/screen/category/bloc/category_bloc.dart';

class CategoryDialog extends StatelessWidget {
  const CategoryDialog({
    Key? key,
    required this.outlineInputBorder,
  }) : super(key: key);

  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListBody(
      children: <Widget>[
        TextFormField(
          maxLength: 255,
          decoration: InputDecoration(
              hintText: LocaleKeys.title.tr(),
              filled: true,
              fillColor: theme.colorScheme.surface.withOpacity(0.1),
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              contentPadding: const EdgeInsets.all(10.0)),
          onChanged: (value) {
            context.read<CategoryBloc>().add(CategoryTextFieldChange(value));
          },
        ),
      ],
    );
  }
}
