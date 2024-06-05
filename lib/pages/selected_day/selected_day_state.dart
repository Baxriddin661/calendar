part of 'selected_day_bloc.dart';


@immutable
abstract class SelectedDayState {

}
class OnSelectedDayState extends SelectedDayState{

  final String? day;
  OnSelectedDayState({this.day});
}