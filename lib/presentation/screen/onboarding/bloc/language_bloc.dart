import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yalda_students_notes/data/repository/category_repository_impl.dart';

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
