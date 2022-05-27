import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yalda_students_notes/core/common/app.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/repository/category_repository.dart';

part 'language_event.dart';

part 'language_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  final CategoryRepository repository;

  OnBoardingBloc(this.repository) : super(OnBoardingInitial()) {
    on<OnBoardingEvent>((event, emit) {
      if (event is OnBoardingLanguageChangeEvent) {
        emit(OnBoardingInitial());
      }
    });
  }
}
