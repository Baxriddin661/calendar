part of 'change_period_bloc.dart';

@immutable
abstract class PeriodChangeEvent {}

class InitPeriodEvent extends PeriodChangeEvent {
  final String month;
  InitPeriodEvent({required this.month});
}

class YearPeriodEvent extends PeriodChangeEvent {
  final String? year;

  YearPeriodEvent({this.year});
}

class MonthPeriodEvent extends PeriodChangeEvent {

  final String? month;
  MonthPeriodEvent({this.month});
}

class WeekPeriodEvent extends PeriodChangeEvent {
  final String? week;
  WeekPeriodEvent({ this.week});

}

class DayPeriodEvent extends PeriodChangeEvent {

  final String? day;
  DayPeriodEvent({ this.day});
}

class DaySelectedEvent extends PeriodChangeEvent{
  final String? day;
  DaySelectedEvent({this.day});

}
