import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/screen/category/bloc/category_bloc.dart';
import 'package:yalda_students_notes/presentation/widgets/loading_state.dart';

class CategoryBottomSheet extends StatelessWidget {
  const CategoryBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CategoryBloc>().add(CategoryStart());
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading || state is CategoryInitial) {
          return const LoadingState();
        } else if (state is CategorySuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.separated(
              itemCount: state.data.length + 1,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(LocaleKeys.select_category.tr(),
                            style: const TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold))),
                  );
                } else {
                  final category = state.data[index - 1];
                  return GestureDetector(
                    onTap: () {
                      //send category back to EditNoteBloc
                      Navigator.pop(
                          context, '${category.id},${category.title}');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 12, left: 12),
                      child: Text(
                        category.title,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                }
              },
              separatorBuilder: (context, index) =>
                  index != 0 ? const Divider() : const SizedBox(),
            ),
          );
        } else {
          return const Center(
            child: Text('Invalid state'),
          );
        }
      },
    );
  }
}
