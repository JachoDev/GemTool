import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pictures_event.dart';
part 'pictures_state.dart';

class PicturesBloc extends Bloc<PicturesEvent, PicturesState> {
  PicturesBloc() : super(PicturesInitial()) {
    on<PicturesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
