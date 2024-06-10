part of 'database_bloc.dart';

@immutable
abstract class DatabaseEvent {}

class DatabaseInitEvent extends DatabaseEvent {
  final String getDateData;
  DatabaseInitEvent({required this.getDateData});

}

class DatabaseCreateEvent extends DatabaseEvent {
  final NoteModel note;

  DatabaseCreateEvent( this.note);
}




class DatabaseUpdateEvent extends DatabaseEvent {
  final NoteModel note;

  DatabaseUpdateEvent(this.note);
}


class DatabaseDeleteEvent extends DatabaseEvent {
  final NoteModel note;

  DatabaseDeleteEvent(this.note);
}
