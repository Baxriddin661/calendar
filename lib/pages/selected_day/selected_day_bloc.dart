import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selected_day_event.dart';
part 'selected_day_state.dart';

class SelectedDayBloc extends Bloc<SelectedDayEvent, SelectedDayState> {
  SelectedDayBloc() : super(OnSelectedDayState()) {
    on<OnSelectedDayEvent>((event, emit) {
     emit(OnSelectedDayState(day: event.day));
    });
  }
}
