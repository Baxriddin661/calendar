import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'change_period_event.dart';

part 'change_period_state.dart';

class ChangePeriodBloc extends Bloc<PeriodChangeEvent, PeriodChangeState> {
  ChangePeriodBloc() : super(PeriodChangeInitial()) {
    DateTime now = DateTime.now();
    String currentYearn = DateFormat('yyyy').format(now);
    String currentMonth = DateFormat('MMMM').format(now);
    String currentWeek = DateFormat('EEEE').format(now);
    int currentDayInt = now.day;
    String currentDay = '$currentDayInt';
    String year = currentYearn;
    String month = currentMonth;
    String week = currentWeek;
    String day = currentDay;
    on<InitPeriodEvent>((event, emit) {
      DateTime now = DateTime.now();
      String currentMonth = DateFormat('MMMM').format(now);
      emit(MonthPeriodState(
        month: event.month ?? currentMonth,
        week: week,
        day: day,
        year: year,
      ));
    });

    on<YearPeriodEvent>((event, emit) {
      DateTime now = DateTime.now();
      String currentYear = DateFormat('yyyy').format(now);
      year = event.year ?? currentYear;
      emit(YearPeriodState(
          year: event.year ?? currentYearn,
          month: month,
          week: week,
          day: day));
    });
    on<MonthPeriodEvent>((event, emit) {
      DateTime now = DateTime.now();
      String currentMonth = DateFormat('MMMM').format(now);
      month = event.month ?? currentMonth;
      emit(MonthPeriodState(
        month: event.month ?? currentMonth,
        week: week,
        day: day,
        year: year,
      ));
    });
    on<WeekPeriodEvent>((event, emit) {
      DateTime now = DateTime.now();
      String currentWeek = DateFormat('EEEE').format(now);
      week = event.week ?? currentWeek;
      emit(WeekPeriodState(
          week: event.week ?? currentWeek, month: month, year: year, day: day));
    });

    on<DayPeriodEvent>((event, emit) {
      DateTime now = DateTime.now();
      int currentDayInt = now.day;
      String currentDay = '$currentDayInt';

      day = event.day ?? currentDay;
      emit(DayPeriodState(
          day: event.day ?? currentDay, week: week, year: year, month: month));
    });

  // on<DaySelectedEvent>((event, emit){
  //   emit(DaySelectedState(day: event.day));
  //
  // });

  }
}
