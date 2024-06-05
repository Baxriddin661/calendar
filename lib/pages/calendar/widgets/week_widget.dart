
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../utils/app_colors.dart';
import '../../../widgets/app_text.dart';
import '../caledar_bloc/change_period_bloc.dart';
import 'add_note_widget.dart';
import 'month_widget.dart';

class WeekWidget extends StatelessWidget {
  WeekWidget({
    required this.week,
    required this.year,
    required this.month,
    required this.day,
    super.key,
  });

  final String day;
  final String week;
  final String year;
  final String month;
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ChangePeriodBloc>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                'Week ',
                fontWeight: FontWeight.w500,
                size: 18,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        bloc.add(DayPeriodEvent(day: '${int.parse(day) - 7}'));
                        bloc.add(WeekPeriodEvent(week: week));
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.greyWhite,
                      ),
                      color: AppColors.grey,
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        bloc.add(DayPeriodEvent(day: '${int.parse(day) + 7}'));
                        bloc.add(WeekPeriodEvent(week: week));
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.greyWhite,
                      ),
                      color: AppColors.grey,
                      icon: const Icon(Icons.arrow_forward_ios_rounded))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 30,
                  runSpacing: 15,
                  children: List.generate(
                    7,
                    (index) {
                      List<DateTime> date =
                          getWeek(year: year, month: month, day: day);
                      return GestureDetector(
                          onTap: () {
                            tapped = !tapped;
                            print('$tapped');
                          },
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  AppText(
                                    monthNumberToName(date[index].month),
                                    color: AppColors.grey,
                                    size: 14,
                                  ),
                                  AppText(
                                    weekNumberToName(date[index].weekday),
                                    fontWeight: FontWeight.w600,
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: (index == 2 && tapped)
                                        ? AppColors.primaryColor
                                        : Colors.transparent,
                                    border: Border.all(
                                        color: AppColors.primaryColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: AppText(
                                  date[index].day.toString(),
                                  fontWeight: FontWeight.w600,
                                  size: 20,
                                  color: (index == 27 && tapped)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              SizedBox(
                                  width: 70,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(50)))),
                                      Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: AppColors.red,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(50)))),
                                      Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: AppColors.orange,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(50)))),
                                    ],
                                  ))
                            ],
                          ));
                    },
                  ),
                ),
              )
            ],
          ),  SizedBox(
            height: 30,
          ),
          AddEventWidget(month: month, year: year, day: day, week: week)
        ],
      ),
    );
  }
}

List<DateTime> getWeek(
    {required String year, required String month, required String day}) {
  List<DateTime> currentWeekDates =
      getCurrentWeekDates(year: year, month: month, day: day);

  // for (var date in currentWeekDates) {
  //   print(DateFormat('EEEE, MMM d, y').format(date));
  // }

  return currentWeekDates;
}

List<DateTime> getCurrentWeekDates(
    {required String year, required String month, required String day}) {
  DateTime now =
      DateTime(int.parse(year), monthNameToNumber(month)!, int.parse(day));
  int currentWeekday = now.weekday; // 1 (Monday) to 7 (Sunday)

  DateTime startOfWeek = now.subtract(Duration(days: currentWeekday - 1));
  DateTime endOfWeek = now.add(Duration(days: 7 - currentWeekday));

  List<DateTime> weekDates = [];
  for (int i = 0; i < 7; i++) {
    weekDates.add(startOfWeek.add(Duration(days: i)));
  }

  return weekDates;
}

String? weekNumberToName(int weekNumber) {
  const WeekNames = {
    1: 'Sunday',
    2: 'Monday',
    3: 'Tuesday',
    4: 'Wednesday',
    5: 'Thursday',
    6: 'Friday',
    7: 'Saturday',
  };

  return WeekNames[weekNumber];
}

String? weekNumberToNameShort(int weekNumber) {
  const WeekNames = {
    1: 'Sun',
    2: 'Mon',
    3: 'Tue',
    4: 'Wed',
    5: 'Thu',
    6: 'Fri',
    7: 'Sat',
  };

  return WeekNames[weekNumber];
}
