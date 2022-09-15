import 'package:bloc/bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc() : super(OnBoardingInitial()) {
    on<OnBoardingEvent>((event, emit) {
      if (event is OnBoardingLanguageChangeEvent) {
        emit(OnBoardingInitial());
      }
    });
  }
}
