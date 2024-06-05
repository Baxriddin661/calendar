part of 'change_period_bloc.dart';

@immutable
abstract class PeriodChangeState {}

class PeriodChangeInitial extends PeriodChangeState {}

class YearPeriodState extends PeriodChangeState {
  final String week;
  final String month;
  final String year;
  final String day;

  YearPeriodState({required this.week,
    required this.month,
    required this.year,
    required this.day});
}

class MonthPeriodState extends PeriodChangeState {
  final String week;
  final String month;
  final String year;
  final String day;

  MonthPeriodState({required this.week,
    required this.month,
    required this.year,
    required this.day});
}

class WeekPeriodState extends PeriodChangeState {
  final String week;
  final String month;
  final String year;
  final String day;

  WeekPeriodState(
      {required this.week,
      required this.month,
      required this.year,
      required this.day});
}

class DayPeriodState extends PeriodChangeState {
  final String week;
  final String month;
  final String year;
  final String day;

  DayPeriodState(
      {required this.day,
      required this.year,
      required this.month,
      required this.week});
}

class DaySelectedState extends PeriodChangeState{
  final String? day;
  DaySelectedState({this.day});

}
