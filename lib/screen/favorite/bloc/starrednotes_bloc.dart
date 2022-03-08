import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'starrednotes_event.dart';
part 'starrednotes_state.dart';

class StarrednotesBloc extends Bloc<StarrednotesEvent, StarrednotesState> {
  StarrednotesBloc() : super(StarrednotesInitial()) {
    on<StarrednotesEvent>((event, emit) {
    });
  }
}
