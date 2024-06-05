part of 'database_bloc.dart';

abstract class DatabaseState {}

class DatabaseInitState extends DatabaseState {}

class DatabaseLoadState extends DatabaseState {}

class DatabaseLoadedState extends DatabaseState {
  final List<NoteModel> notes;

  DatabaseLoadedState({required this.notes});
}

class DatabaseLoadingState extends DatabaseState {}
