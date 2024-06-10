import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../model/note_model.dart';
import '../pages/calendar/widgets/month_widget.dart';
import 'note_database.dart';

part 'database_event.dart';

part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final NoteDatabase noteDatabase;

  DatabaseBloc({required this.noteDatabase}) : super(DatabaseInitState()) {
    on<DatabaseInitEvent>((event, emit) async {
      DateTime now = DateTime.now();
      String currentYearn = DateFormat('yyyy').format(now);
      String currentMonth = DateFormat('MMMM').format(now);
      String currentWeek = DateFormat('EEEE').format(now);
      int currentDayInt = now.day;
      String currentDay = '$currentDayInt';

      emit(DatabaseLoadingState());
      final List<NoteModel> notes;
      notes = await noteDatabase.getNote(event.getDateData != ''
          ? event.getDateData
          : '$currentYearn${monthNameToNumber(currentMonth)}${currentDay}');
      emit(DatabaseLoadedState(notes: notes));
    });

    on<DatabaseCreateEvent>((event, emit) async {
      noteDatabase.insertNote(event.note);
      emit(DatabaseLoadingState());
      final List<NoteModel> notes;
      notes = await noteDatabase.getNote(event.note.id);
      emit(DatabaseLoadedState(notes: notes));
    });

    on<DatabaseUpdateEvent>((event, emit) async {
      noteDatabase.updateNote(event.note);
      emit(DatabaseLoadingState());
      final List<NoteModel> notes;
      notes = await noteDatabase.getNote(event.note.id);
      emit(DatabaseLoadedState(notes: notes));
    });

    on<DatabaseDeleteEvent>((event, emit) async {
      noteDatabase.deleteNote(event.note);
      emit(DatabaseLoadingState());
      final List<NoteModel> notes;
      notes = await noteDatabase.getNote(event.note.sortId);
      emit(DatabaseLoadedState(notes: notes));
    });
  }
}
