part of 'selected_day_bloc.dart';

@immutable
abstract class SelectedDayEvent {}
class OnSelectedDayEvent extends SelectedDayEvent{

  final String? day;
  OnSelectedDayEvent({this.day});
}