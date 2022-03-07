import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'addnote_event.dart';
part 'addnote_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  AddNoteBloc() : super(AddNoteInitial()) {
    on<AddNoteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
