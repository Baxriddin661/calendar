
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_colors.dart';
import '../../../widgets/app_text.dart';
import '../caledar_bloc/change_period_bloc.dart';
import 'month_widget.dart';

class YearWidget extends StatelessWidget {
  YearWidget({super.key, required this.year});
  final int year;



  DateTime startDate = DateTime(1950, 1, 1);

  DateTime endDate = DateTime(2950, 1, 1);

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
                year.toString(),
                fontWeight: FontWeight.w500,
                size: 18,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        if (year == startDate.year) {
                          null;
                        } else {
                          bloc.add(YearPeriodEvent(year: '${year - 1}'));
                        }
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
                        if (year == endDate.year) {
                          null;
                        } else {
                          bloc.add(YearPeriodEvent(year: '${year + 1}'));
                        }
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
          SizedBox(height: 20,),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 40,
                  runSpacing: 20,
                  children: List.generate(
                    12,
                    (monthIndex) {
                      DateTime now = DateTime(
                        year,
                        monthIndex + 1,
                      );
                      String currentMonth = DateFormat('MMMM').format(now);
                      return GestureDetector(
                          onTap: () {
                            String newMonth =
                                monthNumberToName(monthIndex + 1) ?? 'Januar';
                            bloc.add(MonthPeriodEvent(month: newMonth));
                          },
                          child: SizedBox(
                            width: 80,
                            child: Column(
                              children: [
                                AppText(
                                  currentMonth,
                                  fontWeight: FontWeight.w600,
                                  size: 14,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(1),
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.primaryColor,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 1,
                                      runSpacing: 1,
                                      children: List.generate(
                                          getDaysInMonth(year, monthIndex + 1),
                                          (dayIndex) {
                                        return Container(
                                          padding: EdgeInsets.all(1),
                                          child: AppText(
                                            '${dayIndex + 1} ',
                                            size: 8,
                                          ),
                                        );
                                      })),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                SizedBox(
                                    width: 100,
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
                            ),
                          ));
                    },
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void getYear() {
    int year = 2023; // Replace with the year you want
    List<DateTime> allDatesInYear = getAllDatesInYear(year);

    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    allDatesInYear.forEach((date) {
      print(dateFormat.format(date));
    });
  }
}

int getDaysInMonth(int year, int month) {
  // If month is December, go to the next year's January
  int nextMonth = month == 12 ? 1 : month + 1;
  int nextMonthYear = month == 12 ? year + 1 : year;

  // Subtract one day from the first day of the next month
  DateTime firstDayNextMonth = DateTime(nextMonthYear, nextMonth, 1);
  DateTime lastDayCurrentMonth = firstDayNextMonth.subtract(Duration(days: 1));

  return lastDayCurrentMonth.day;
}

List<DateTime> getAllDatesInYear(int year) {
  List<DateTime> dates = [];
  DateTime currentDate = DateTime(year, 1, 1);
  DateTime endDate = DateTime(year + 1, 1, 1);

  while (currentDate.isBefore(endDate)) {
    dates.add(currentDate);
    currentDate = currentDate.add(Duration(days: 1));
  }

  return dates;
}
